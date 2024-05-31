from enum import Enum
from collections import deque
import time


# Enum to represent job status
class Status(Enum):
    CREATED = "created"
    READY = "ready"
    RUNNING = "running"
    EXIT = "exit"


# Class to represent a job
class Job:
    def __init__(self, job_number, arrival_time, actual_execution_time, priority, queue_number, status):
        self.job_number = job_number
        self.arrival_time = arrival_time
        self.actual_execution_time = actual_execution_time
        self.priority = priority
        self.queue_number = queue_number
        self.status = status
        self.remaining_time = actual_execution_time
        self.running_time = 0  # Track running time

    def __str__(self):
        return (f"Job #{self.job_number} - Arrival: {self.arrival_time:.2f}, "
                f"Execution Time: {self.actual_execution_time:.2f}, Priority: {self.priority}, "
                f"Queue: {self.queue_number}, Status: {self.status.value} ,Remaining time: {self.remaining_time}")


# Enum for scheduling switch
class Switch(Enum):
    PREEMPTIVE = "preemptive_scheduling"
    NON_PREEMPTIVE = "non_preemptive_scheduling"


# Class representing a linear queue
class LinearQueue:
    def __init__(self):
        self.ready_queue = deque()
        self.aging_threshold = 0  # Default aging threshold

    def enqueue(self, job):
        job.status = Status.READY
        self.ready_queue.append(job)

    def dequeue(self):
        if self.is_empty():
            return None
        return self.ready_queue.popleft()

    def is_empty(self):
        return len(self.ready_queue) == 0


# Class representing a FIFO queue
class FIFO(LinearQueue):
    def __init__(self):
        super().__init__()
        self.aging_threshold = 3  # Set aging threshold
        self.transfer_list = []  # List to store transferred jobs

    def runMLQ(self , priority_based_switch , jobs, context_switching_time):

        self.process_jobs_Fifo(jobs, context_switching_time)

        # if priority_based_switch == Switch.NON_PREEMPTIVE:
        #     priority = PriorityBased(priority_based_switch)
        #     priority.process_jobs(jobs, context_switching_time)
        #
        # elif priority_based_switch == Switch.PREEMPTIVE:
        #     priority = PriorityBased(priority_based_switch)
        #     priority.process_jobs(jobs, context_switching_time)

    def process_jobs_Fifo(self, jobs, context_switching_time):
        current_time = 0
        running_job = None
        cpu_available = True

        # Process the first job outside the loop
        if jobs:
            current_job = jobs.pop(0)
            current_job.status = Status.RUNNING
            running_job = current_job
            cpu_available = False
            print(f"At time {current_time}: -----------------starting JOB {running_job.job_number}------------------")
            print(f"Job status {running_job.status.value}")
            execution_time = min(running_job.remaining_time, 1)
            time.sleep(execution_time)
            running_job.remaining_time -= execution_time
            running_job.running_time += execution_time
            print(
                f"At time {current_time + 1}: Running Job {running_job.job_number}, {running_job.remaining_time} time units remaining.")

            if running_job.remaining_time <= 0:
                running_job.status = Status.EXIT
                cpu_available = True
                print(f"Job status {running_job.status.value}")
                print(f"-----------------finishing JOB {running_job.job_number}------------------")
                running_job = None

            current_time += 1

        while jobs or not self.is_empty() or running_job:
            # Print the current time and queue status
            print(
                f"At time {current_time}: CPU available: {cpu_available}, Ready queue: {[job.job_number for job in self.ready_queue]}")

            # Add arriving jobs to the queue
            while jobs and jobs[0].arrival_time <= current_time:
                current_job = jobs.pop(0)
                self.enqueue(current_job)
                print(f"At time {current_time}: Job {current_job.job_number} arrived and added to ready queue.")
                print(f"Ready queue: {[job.job_number for job in self.ready_queue]}")

            # Execute the job if CPU is available
            if cpu_available and not self.is_empty():
                running_job = self.dequeue()
                running_job.status = Status.RUNNING
                cpu_available = False
                print(f"-----------------starting JOB {running_job.job_number}------------------")
                print(f"Job status {running_job.status.value}")

            # Simulate job execution
            if running_job:
                execution_time = min(running_job.remaining_time, 1)
                time.sleep(execution_time)
                running_job.remaining_time -= execution_time
                running_job.running_time += execution_time
                print(
                    f"At time {current_time + 1}: Running Job {running_job.job_number}, {running_job.remaining_time} time units remaining.")

                # Transfer the job if it exceeds the aging threshold
                if running_job.running_time > self.aging_threshold:
                    running_job.status = Status.READY
                    self.transfer_list.append(running_job)
                    print(f"At time {current_time}: Job {running_job.job_number} exceeded aging threshold and transferred.")
                    running_job = None
                    cpu_available = True

                # Finish the job if execution is complete
                elif running_job.remaining_time <= 0:
                    running_job.status = Status.EXIT
                    cpu_available = True
                    print(f"Job status {running_job.status.value}")
                    print(f"-----------------finishing JOB {running_job.job_number}------------------")
                    running_job = None

            current_time += 1

        # Print transferred jobs
        # if self.transfer_list:
        #     print("Transferred Jobs:")
        #     for job in self.transfer_list:
        #         print(job)


# Main function to test the FIFO queue
def main():
    jobs = []
    job1 = Job(1, 0.0, 10, 3, 1, Status.CREATED)
    jobs.append(job1)
    job2 = Job(2, 2, 1, 2, 2, Status.CREATED)
    jobs.append(job2)
    job3 = Job(3, 4, 3.0, 1, 3, Status.CREATED)
    jobs.append(job3)
    job4 = Job(4, 8, 5, 5, 1, Status.CREATED)
    jobs.append(job4)
    job5 = Job(5, 12, 2, 4, 2, Status.CREATED)
    jobs.append(job5)

    fifo = FIFO()
    context_switching_time = 1
    fifo.process_jobs(jobs, context_switching_time)


if __name__ == "__main__":
    main()