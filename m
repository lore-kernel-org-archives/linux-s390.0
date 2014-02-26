From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/3] Improved yield performance
Date: Wed, 26 Feb 2014 16:14:16 +0100
Message-ID: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is the reworked yield heuristics series against kvm/queue with
your suggested changes.

Attached is a minimized testcase that reproduces the performance
win  (runtime 0:50 instead of 1:00). The constants and the setup
seem a bit artificial but these seem to reproduce the problem on my
test system: as soon as there is contention from other guests the 
patch improves the runtime of belows testcase. The original test
had 8 competing guests with 4 cpus, I simplified that a bit to have
one big guest as cpu stealer.

                           host 20 cpus
GUEST1 (20vCPUS)			GUEST2(40vCPUS)
runs the test				all 40 CPUs cpu bound


The testcase stresses the IPC system call, since that creates a lot
of diag44 exits on s390 if contended.

Some other spinlock tests like fio on guest tmpfs seem to be unaffected.

Please consider for kvm/queue. If you have some performance tests
a regression run on x86 is welcome.

Christian

Michael Mueller (3):
  KVM: s390: implementation of kvm_arch_vcpu_runnable()
  KVM: add kvm_arch_vcpu_runnable() test to kvm_vcpu_on_spin() loop
  KVM/s390: Set preempted flag during vcpu wakeup and interrupt delivery

 arch/s390/kvm/interrupt.c | 3 +++
 arch/s390/kvm/kvm-s390.c  | 4 +---
 virt/kvm/kvm_main.c       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-------- snip-------------
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define NUM 800
#define ACTIVE 40
#define LOOPS 800

static int mutexsem;

static void busy_work(void)
{
        int i;
        double dummy = 100;

        for (i=0; i<10000; i++) {
                dummy/=1.1;
                asm volatile ("":"+r" (dummy)::"memory");
        }
}

static void *child(void *unused)
{
        int j;
        struct sembuf sops;

        for (j = 0; j < LOOPS; j++) {
                sops.sem_num = 0;
                sops.sem_op = -1;
                sops.sem_flg = 0;
                semop(mutexsem, &sops, 1);

                busy_work();

                sops.sem_num = 0;
                sops.sem_op = 1;
                sops.sem_flg = 0;
                semop(mutexsem, &sops, 1);
        }
        return NULL;
}

static void do_fork(long number)
{
        pid_t pid;

        pid = fork();
        switch (pid) {
        case 0:
                child((void *) number);
                exit(0);
        case -1:
                perror("Couldn't fork child - ");
                exit(1);
        default:
                break;
        }
}

union semun {
        int              val;
        struct semid_ds *buf;
        unsigned short  *array;
        struct seminfo  *__buf;
};

int main(int argc, char **argv)
{
        unsigned i;
        struct sembuf sops;
        union semun value;

        mutexsem = semget(0xdead, 1, IPC_CREAT);
        value.val = 0;
        semctl(mutexsem, 0, SETVAL, value);
        for (i = 0; i < NUM; i++)
                do_fork(i);

        for (i=0; i<ACTIVE; i++) {
                sops.sem_num = 0;
                sops.sem_op = 1;
                sops.sem_flg = 0;
                semop(mutexsem, &sops, 1);
        }

        for (i = 0; i < 1000; i++)
                wait(NULL);
        exit(0);
}

-------- snip-------------

-- 
1.8.4.2
