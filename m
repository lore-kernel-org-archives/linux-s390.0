Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgKEM1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Nov 2020 07:27:35 -0500
Date: Thu, 5 Nov 2020 13:27:25 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on
 bind/unbind of queue device
Message-ID: <20201105132725.30485f05.pasic@linux.ibm.com>
In-Reply-To: <eb27fc27-e236-7b16-9d8c-814bba816934@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-9-akrowiak@linux.ibm.com>
        <20201028145725.1a81c5cf.pasic@linux.ibm.com>
        <055284df-87d8-507a-d7d7-05a73459322d@linux.ibm.com>
        <20201104135218.666bf0f5.pasic@linux.ibm.com>
        <eb27fc27-e236-7b16-9d8c-814bba816934@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 4 Nov 2020 16:20:26 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> > But I'm sure the code is suggesting it can, because
> > vfio_ap_mdev_filter_guest_matrix() has a third parameter called filter_apid,
> > which governs whether the apm or the aqm bit should be removed. And
> > vfio_ap_mdev_filter_guest_matrix() does get called with filter_apid=false in
> > assign_domain_store() and I don't see subsequent unlink operations that would
> > severe q->mdev_matrix.  
> 
> I think you may be conflating two different things. The q in q->matrix_mdev
> represents a queue device bound to the driver. The link to matrix_mdev
> indicates the APQN of the queue device is assigned to the matrix_mdev.
> When a new domain is assigned to matrix_mdev, we know that
> all APQNS currently assigned to the shadow_apcb  are bound to the vfio 
> driver
> because of previous filtering, so we are only concerned with those APQNs
> with the APQI of the new domain being assigned.
> 
> 1. Queues bound to vfio_ap:
>      04.0004
>      04.0047
> 2. APQNs assigned to matrix_mdev:
>      04.0004
>      04.0047
> 3. shadow_apcb:
>      04.0004
>      04.0047
> 4. Assign domain 0054 to matrix_mdev
> 5. APQI 0054 gets filtered because 04.0054 not bound to vfio_ap
> 6. no change to shadow_apcb:
>      04.0004
>      04.0047

Let me please expand on your example. For reference see the filtering
code after the example.

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
     05.0004
     05.0047
     05.0054
because now vfio_ap_mdev_filter_guest_matrix() is called with filter_apid=true
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
11. shadow_apcb changes to 
     04.0004
     04.0047
     05.0004
     05.0047
     because now filter_guest_matrix() is called with filter_apid=false
     and apqis 0053 and 0054 get filtered
12. 05.0054 gets removed (unbound)
13. with your current code we unplug adapter 05 from shadow_apcb
    despite the fact that 05.0054 was not in the shadow_apcb in
    the first place
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
16. shadow_apcb changes to 
     <empty>
     because now filter_guest_matrix() is called with filter_apid=true
     and apqn 04 gets filtered because queues 04.0053 are not bound
     and apqn 05 gets filtered because queues 05.0053 are not bound

static int vfio_ap_mdev_filter_guest_matrix(struct ap_matrix_mdev *matrix_mdev, 
                                            bool filter_apid)                   
{                                                                               
        struct ap_matrix shadow_apcb;                                           
        unsigned long apid, apqi, apqn;                                         
                                                                                
        memcpy(&shadow_apcb, &matrix_mdev->matrix, sizeof(struct ap_matrix));   
                                                                                
        for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {       
                /*                                                              
                 * If the APID is not assigned to the host AP configuration,    
                 * we can not assign it to the guest's AP configuration         
                 */                                                             
                if (!test_bit_inv(apid, (unsigned long *)                       
                                  matrix_dev->config_info.apm)) {               
                        clear_bit_inv(apid, shadow_apcb.apm);                   
                        continue;                                               
                }                                                               
                                                                                
                for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,             
                                     AP_DOMAINS) {                              
                        /*                                                      
                         * If the APQI is not assigned to the host AP           
                         * configuration, then it can not be assigned to the    
                         * guest's AP configuration                             
                         */                                                     
                        if (!test_bit_inv(apqi, (unsigned long *)               
                                          matrix_dev->config_info.aqm)) {       
                                clear_bit_inv(apqi, shadow_apcb.aqm);           
                                continue;                                       
                        }                                                       
                                                                                
                        /*                                                      
                         * If the APQN is not bound to the vfio_ap device       
                         * driver, then we can't assign it to the guest's       
                         * AP configuration. The AP architecture won't          
                         * allow filtering of a single APQN, so let's filter    
                         * the APID.                                            
                         */                                                     
                        apqn = AP_MKQID(apid, apqi);                            
                                                                                
                        if (!vfio_ap_mdev_get_queue(matrix_mdev, apqn)) {       
                                if (filter_apid) {                              
                                        clear_bit_inv(apid, shadow_apcb.apm);   
                                        break;                                  
                                }                                               
                                                                                
                                clear_bit_inv(apqi, shadow_apcb.aqm);           
                                continue;                                       
                        }                                                       
                }

I realize this scenario (to play through to the end) requires  
manually unbound queue (more precisely queue missing not because
of host ap config or because of a[pq]mask), but just one 'hole' suffices.

I'm afraid, that I might be bitching around, because last time it was me
who downplayed the effects of such 'holes'.

Nevertheless, I would like to ask you to verify the scenario I've
sketched, or complain if I've gotten something wrong.

Regarding solutions to the problem. It makes no sense to talk about a
solution, before agreeing on the existence of the problem. Nevertheless
I will write down two sentences, mostly as a reminder to myself, for the
case we do agree on the existence of the problem. The simplest approach
is to always filter by apid. That way we get a quirky adapter unplug
right at steps 4, but it won't create the complicated mess we have in
the rest of the points. Another idea is to restrict the overprovisioning
of domains. Basically we would make the step 4 fail because we detected
a 'hole'. But this idea has its own problems, and in some scenarios
it does boil down to the unplug the adapter rule. 

[..]

> 
> I'm not sure why you are bringing up unlinking in the context of assigning
> a new domain. Unlinking only occurs when an APID or APQI is unassigned.

Are you certain? What about vfio_ap_mdev_on_cfg_remove()? I believe it
unplugs from the shadow_apcb, but it does not change the
assignments to the matrix_mdev. We do that so we know in remove that the
queue was already cleaned up, and does not need more cleanup.

Regards,
Halil
