From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v7 13/15] KVM: s390: add gib_alert_irq_handler()
Date: Tue, 5 Feb 2019 13:52:17 +0100
Message-ID: <3599eeec-eec1-6326-ba34-5e0f64c45934@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-14-mimu@linux.ibm.com>
 <50f05038-f414-50f5-dbe7-e2bcca0b8433@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50f05038-f414-50f5-dbe7-e2bcca0b8433@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 05.02.19 12:38, Pierre Morel wrote:
> On 31/01/2019 09:52, Michael Mueller wrote:
>> The patch implements a handler for GIB alert interruptions
>> on the host. Its task is to alert guests that interrupts are
>> pending for them.
>>
>> A GIB alert interrupt statistic counter is added as well:
>>
>> $ cat /proc/interrupts
>>            CPU0       CPU1
>>    ...
>>    GAL:      23         37   [I/O] GIB Alert
>>    ...
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
> 
> The only thing that bother me is the short timer's expiration value.
> But it is optimization and it is working for me so.
> 
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


Thanks, Pierre.

For completion I want to add that one sees roughly 1 timer
restart per vcpu that gets kicked in my test scenario with
12 AP IRQ guests. The guests have 4 x 1, 4 x 4 and  4 x 8 vcpus
backed by 8 IFLs. Furthermore the 12 guests share 4 CEX5C cards
each configured with 3 AP queues. On the guest runs a single
threaded AP driver that performs RSA decryptions with CRT private
keys with a short 512 bit length to get many ops/s. That
run has no additional cpu load.

./run_ap_load.sh 12
[1] 12:53:09 [SUCCESS] root@ap04
[2] 12:53:09 [SUCCESS] root@ap08
[3] 12:53:10 [SUCCESS] root@ap02
[4] 12:53:10 [SUCCESS] root@ap03
[5] 12:53:10 [SUCCESS] root@ap01
[6] 12:53:10 [SUCCESS] root@ap12
[7] 12:53:10 [SUCCESS] root@ap06
[8] 12:53:10 [SUCCESS] root@ap05
[9] 12:53:10 [SUCCESS] root@ap07
[10] 12:53:10 [SUCCESS] root@ap10
[11] 12:53:10 [SUCCESS] root@ap09
[12] 12:53:10 [SUCCESS] root@ap11
KVM guests:          12
ica_perf threads:    1
stress cpu threads:  0
stress io threads:   0
expected  AP IRQs:   600048
observed  AP IRQs:   600048
observed VAI IRQs:   1311
observed GAL IRQs:   575505


__gal_stats_ipm_dirty = 613762
__gal_stats_timer_active = 0
__gal_stats_timer_no_restart = 600048
__gal_stats_timer_not_active = 600048
__gal_stats_timer_restart = 613762
__gal_stats_vcpus_kicked = 599688


The counters are placed as follows:

@@ -2998,6 +2999,7 @@ static void __airqs_kick_single_vcpu(struct kvm 
*kvm, u8 deliverable_mask)
                         if (test_and_set_bit(vcpu_id, gi->kicked_mask))
                                 return;
                         kvm_s390_vcpu_wakeup(vcpu);
+                       __gal_stats_inc(kvm, vcpus_kicked);
                         return;
                 }
         }
@@ -3013,11 +3015,14 @@ static enum hrtimer_restart 
gisa_vcpu_kicker(struct hrtimer *timer)

         pending_mask = gisa_get_ipm_or_restore_iam(gi);
         if (pending_mask) {
+               __gal_stats_inc(kvm, ipm_dirty);
                 __airqs_kick_single_vcpu(kvm, pending_mask);
                 hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
+               __gal_stats_inc(kvm, timer_restart);
                 return HRTIMER_RESTART;
         };

+       __gal_stats_inc(kvm, timer_no_restart);
         return HRTIMER_NORESTART;
  }


Cheers,
Michael
