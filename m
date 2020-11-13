Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbgKMUhI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 15:37:08 -0500
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on
 bind/unbind of queue device
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-9-akrowiak@linux.ibm.com>
 <20201028145725.1a81c5cf.pasic@linux.ibm.com>
 <055284df-87d8-507a-d7d7-05a73459322d@linux.ibm.com>
 <20201104135218.666bf0f5.pasic@linux.ibm.com>
 <eb27fc27-e236-7b16-9d8c-814bba816934@linux.ibm.com>
 <20201105132725.30485f05.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <f139edf3-f88c-aea3-d50e-4aee53ade7bc@linux.ibm.com>
Date: Fri, 13 Nov 2020 15:36:57 -0500
MIME-Version: 1.0
In-Reply-To: <20201105132725.30485f05.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/5/20 7:27 AM, Halil Pasic wrote:
> On Wed, 4 Nov 2020 16:20:26 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>>> But I'm sure the code is suggesting it can, because
>>> vfio_ap_mdev_filter_guest_matrix() has a third parameter called filter_apid,
>>> which governs whether the apm or the aqm bit should be removed. And
>>> vfio_ap_mdev_filter_guest_matrix() does get called with filter_apid=false in
>>> assign_domain_store() and I don't see subsequent unlink operations that would
>>> severe q->mdev_matrix.
>> I think you may be conflating two different things. The q in q->matrix_mdev
>> represents a queue device bound to the driver. The link to matrix_mdev
>> indicates the APQN of the queue device is assigned to the matrix_mdev.
>> When a new domain is assigned to matrix_mdev, we know that
>> all APQNS currently assigned to the shadow_apcb  are bound to the vfio
>> driver
>> because of previous filtering, so we are only concerned with those APQNs
>> with the APQI of the new domain being assigned.
>>
>> 1. Queues bound to vfio_ap:
>>       04.0004
>>       04.0047
>> 2. APQNs assigned to matrix_mdev:
>>       04.0004
>>       04.0047
>> 3. shadow_apcb:
>>       04.0004
>>       04.0047
>> 4. Assign domain 0054 to matrix_mdev
>> 5. APQI 0054 gets filtered because 04.0054 not bound to vfio_ap
>> 6. no change to shadow_apcb:
>>       04.0004
>>       04.0047
> Let me please expand on your example. For reference see the filtering
> code after the example.

Since our face to face discussion, I've made changes which
affect the scenario you laid out. The following shows the difference
in results using your scenario. Let me know what you think.

1. Queues bound to vfio_ap:
      04.0004
      04.0047
      05.0004
      05.0047
      05.0054
2. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
3. shadow_apcb:
      04.0004
      04.0047
4. Assign domain 0054 to matrix_mdev
5. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
      04.0054
5. APQI 0054 gets filtered because 04.0054 not bound to vfio_ap
6. no change to shadow_apcb:
      04.0004
      04.0047
7. assign adapter 05
8. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
      04.0054
      05.0004
      05.0047
      05.0054
9. shadow_apcb changes to:
      04.0004
      04.0047
      05.0004
      05.0047
      because adapter 05 is checked against the APQIs in the
      shadow_apcb (0004, 0047) and since 05.0004 and
      05.0047 are bound to the driver, adapter 05 is
      hot plugged.
10. assign domain 0052
11. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
      04.0053
      04.0054
      05.0004
      05.0047
      05.0053
      05.0054
11. shadow_apcb remains
      04.0004
      04.0047
      05.0004
      05.0047
      because domain 0052 is checked against adapters assigned to
      shadow_apcb and rejected because neither 04.0052 nor 05.0052
      is bound to the vfio_ap driver.
12. 05.0054 gets removed (unbound)
13. Nothing is removed because 05.0054 is not assigned to shadow_apcb
14. unassign adapter 05
15. unassign domain 0053
16. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
      04.0054
17. shadow apcb is
     04.0004
     04.0047
16. assign adapter 05
15. APQNs assigned to matrix_mdev:
      04.0004
      04.0047
      04.0054
      05.0004
      05.0047
      05.0054
16. shadow_apcb changes to:
     04.0004
     04.0047
     05.0004
     05.0047
     because adapter 05 is checked against APQIs (0004, 0047)
     in shadow_apcb and since queues 05.0004 and 05.0047
     are bound to vfio_ap, the adapter is hot plugged

>
> 1. Queues bound to vfio_ap:
>       04.0004
>       04.0047
>       05.0004
>       05.0047
>       05.0054
> 2. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
> 3. shadow_apcb:
>       04.0004
>       04.0047
> 4. Assign domain 0054 to matrix_mdev
> 5. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
>       04.0054
> 5. APQI 0054 gets filtered because 04.0054 not bound to vfio_ap
> 6. no change to shadow_apcb:
>       04.0004
>       04.0047
> 7. assign adapter 05
> 8. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
>       04.0054
>       05.0004
>       05.0047
>       05.0054
> 9. shadow_apcb changes to:
>       05.0004
>       05.0047
>       05.0054
> because now vfio_ap_mdev_filter_guest_matrix() is called with filter_apid=true
> 10. assign domain 0052
> 11. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
>       04.0053
>       04.0054
>       05.0004
>       05.0047
>       05.0053
>       05.0054
> 11. shadow_apcb changes to
>       04.0004
>       04.0047
>       05.0004
>       05.0047
>       because now filter_guest_matrix() is called with filter_apid=false
>       and apqis 0053 and 0054 get filtered
> 12. 05.0054 gets removed (unbound)
> 13. with your current code we unplug adapter 05 from shadow_apcb
>      despite the fact that 05.0054 was not in the shadow_apcb in
>      the first place
> 14. unassign adapter 05
> 15. unassign domain 0053
> 16. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
>       04.0054
> 17. shadow apcb is
>      04.0004
>      04.0047
> 16. assign adapter 05
> 15. APQNs assigned to matrix_mdev:
>       04.0004
>       04.0047
>       04.0054
>       05.0004
>       05.0047
>       05.0054
> 16. shadow_apcb changes to
>       <empty>
>       because now filter_guest_matrix() is called with filter_apid=true
>       and apqn 04 gets filtered because queues 04.0053 are not bound
>       and apqn 05 gets filtered because queues 05.0053 are not bound
>
> static int vfio_ap_mdev_filter_guest_matrix(struct ap_matrix_mdev *matrix_mdev,
>                                              bool filter_apid)
> {
>          struct ap_matrix shadow_apcb;
>          unsigned long apid, apqi, apqn;
>                                                                                  
>          memcpy(&shadow_apcb, &matrix_mdev->matrix, sizeof(struct ap_matrix));
>                                                                                  
>          for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
>                  /*
>                   * If the APID is not assigned to the host AP configuration,
>                   * we can not assign it to the guest's AP configuration
>                   */
>                  if (!test_bit_inv(apid, (unsigned long *)
>                                    matrix_dev->config_info.apm)) {
>                          clear_bit_inv(apid, shadow_apcb.apm);
>                          continue;
>                  }
>                                                                                  
>                  for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>                                       AP_DOMAINS) {
>                          /*
>                           * If the APQI is not assigned to the host AP
>                           * configuration, then it can not be assigned to the
>                           * guest's AP configuration
>                           */
>                          if (!test_bit_inv(apqi, (unsigned long *)
>                                            matrix_dev->config_info.aqm)) {
>                                  clear_bit_inv(apqi, shadow_apcb.aqm);
>                                  continue;
>                          }
>                                                                                  
>                          /*
>                           * If the APQN is not bound to the vfio_ap device
>                           * driver, then we can't assign it to the guest's
>                           * AP configuration. The AP architecture won't
>                           * allow filtering of a single APQN, so let's filter
>                           * the APID.
>                           */
>                          apqn = AP_MKQID(apid, apqi);
>                                                                                  
>                          if (!vfio_ap_mdev_get_queue(matrix_mdev, apqn)) {
>                                  if (filter_apid) {
>                                          clear_bit_inv(apid, shadow_apcb.apm);
>                                          break;
>                                  }
>                                                                                  
>                                  clear_bit_inv(apqi, shadow_apcb.aqm);
>                                  continue;
>                          }
>                  }
>
> I realize this scenario (to play through to the end) requires
> manually unbound queue (more precisely queue missing not because
> of host ap config or because of a[pq]mask), but just one 'hole' suffices.
>
> I'm afraid, that I might be bitching around, because last time it was me
> who downplayed the effects of such 'holes'.
>
> Nevertheless, I would like to ask you to verify the scenario I've
> sketched, or complain if I've gotten something wrong.

Your scenario looks correct and convinced me to change
the filtering logic giving the results I pointed out above.
It was a good catch on your part, so I thank you for
the review.

>
> Regarding solutions to the problem. It makes no sense to talk about a
> solution, before agreeing on the existence of the problem. Nevertheless
> I will write down two sentences, mostly as a reminder to myself, for the
> case we do agree on the existence of the problem. The simplest approach
> is to always filter by apid. That way we get a quirky adapter unplug
> right at steps 4, but it won't create the complicated mess we have in
> the rest of the points. Another idea is to restrict the overprovisioning
> of domains. Basically we would make the step 4 fail because we detected
> a 'hole'. But this idea has its own problems, and in some scenarios
> it does boil down to the unplug the adapter rule.

I made the following changes that I believe rectify this problem:
1. On guest startup, the shadow_apcb is initialized by filtering the
     mdev's matrix by APID (i.e., if an APQN derived from a particular
     APID and the APQIs assigned to the mdev's matrix does not
     reference a queue device bound to vfio_ap, that APID is not
     assigned to the shadow_apcb).
2. On adapter assignment, if each APQN derived from the APID
     being assigned and the APQIs assigned to the shadow_apcb
     does not reference a queue bound to vfio_ap, the adapter
     will not be hot plugged.
3. On adapter unassignment, if the APID is set in the shadow_apcb,
     the adapter will be hot unplugged.
4. On domain assignment, if each APQN derived from the APQI
     being assigned and the APIDs assigned to the shadow_apcb
     does not reference a queue bound to vfio_ap, the domain
     will not be hot plugged.
5. On domain unassignment, if the APQI is set in the shadow_apcb,
     the domain will be hot unplugged.
6. On probe:
     a. For the queue's APID, the same logic as #2 will be used.
     b. For the queue's APQI, the same logic as #4 will be used.
7. On remove, if the APQN of the queue being unbound is assigned
     to the shadow_apcb, the adapter will be hot unplugged.

>   
>
> [..]
>
>> I'm not sure why you are bringing up unlinking in the context of assigning
>> a new domain. Unlinking only occurs when an APID or APQI is unassigned.
> Are you certain? What about vfio_ap_mdev_on_cfg_remove()? I believe it
> unplugs from the shadow_apcb, but it does not change the
> assignments to the matrix_mdev. We do that so we know in remove that the
> queue was already cleaned up, and does not need more cleanup.

What you say is true; however, that is not related to my comment.
I asked why you were bringing up unlinking in the context of
assigning a new domain. The point you just made above has to
do with unassigning adapters/domains.

>
> Regards,
> Halil
>
