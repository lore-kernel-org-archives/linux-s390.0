Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgLAWRy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 17:17:54 -0500
Subject: Re: [PATCH v12 12/17] s390/vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
 <20201124214016.3013-13-akrowiak@linux.ibm.com>
 <20201129025250.16eb8355.pasic@linux.ibm.com>
 <103cbe02-2093-c950-8d65-d3dc385942ce@linux.ibm.com>
 <20201201003227.0c3696fc.pasic@linux.ibm.com>
 <20201201185659.72ca96c8.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <84d1126b-08f8-9f8e-ad72-490625aabbd6@linux.ibm.com>
Date: Tue, 1 Dec 2020 17:12:56 -0500
MIME-Version: 1.0
In-Reply-To: <20201201185659.72ca96c8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 12/1/20 12:56 PM, Halil Pasic wrote:
> On Tue, 1 Dec 2020 00:32:27 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>>>
>>> On 11/28/20 8:52 PM, Halil Pasic wrote:
>> [..]
>>>>> * Unassign adapter from mdev's matrix:
>>>>>
>>>>>     The domain will be hot unplugged from the KVM guest if it is
>>>>>     assigned to the guest's matrix.
>>>>>
>>>>> * Assign a control domain:
>>>>>
>>>>>     The control domain will be hot plugged into the KVM guest if it is not
>>>>>     assigned to the guest's APCB. The AP architecture ensures a guest will
>>>>>     only get access to the control domain if it is in the host's AP
>>>>>     configuration, so there is no risk in hot plugging it; however, it will
>>>>>     become automatically available to the guest when it is added to the host
>>>>>     configuration.
>>>>>
>>>>> * Unassign a control domain:
>>>>>
>>>>>     The control domain will be hot unplugged from the KVM guest if it is
>>>>>     assigned to the guest's APCB.
>>>> This is where things start getting tricky. E.g. do we need to revise
>>>> filtering after an unassign? (For example an assign_adapter X didn't
>>>> change the shadow, because queue XY was missing, but now we unplug domain
>>>> Y. Should the adapter X pop up? I guess it should.)
>>> I suppose that makes sense at the expense of making the code
>>> more complex. It is essentially what we had in the prior version
>>> which used the same filtering code for assignment as well as
>>> host AP configuration changes.
>>>    
>> Will have to think about it some more. Making the user unplug and
>> replug an adapter because at some point it got filtered, but there
>> is no need to filter it does not feel right. On the other hand, I'm
>> afraid I'm complaining in circles.
> I did some thinking. The following statements are about the state of
> affairs, when all 17 patches are applied. I'm commenting here, because
> I believe this is the patch that introduces the most controversial code.
>
> First about low level problems with the current code/design. The other is
> empty handling in vfio_ap_assign_apid_to_apcb() (and
> vfio_ap_assign_apqi_to_apcb()) is troublesome. The final product
> allows for over-commitment, i.e. assignment of e.g. domains that
> are not in the crypto host config. Let's assume the host LPAR
> has usage domains 1 and 2, and adapters 1, 2, and 3. The apmask
> and aqmask are both 0 (all in on vfio), all bound. We start with an empty
> mdev that is tied to a running guest:
> assign_adapter 1
> assign_adapter 2
> assign_adapter 3
> assign_adapter 4
> all of these will work. The resulting shadow_apcb is completely empty. No
> commit_apcb.
> assign_domain 1
> assign_domain 2
> assign_domain 3
> all of these will work. But again the shadow_apcb is completely empty at
> the end: we did get to the loop that is checking the boundness of the
> queues, but please note that we are checking against matrix.apm, and
> adapter 4 is not in the config of the host.
>
> I've hacked up a fixup patch for these problems that simplifies the
> code considerably, but there are design level issues, that run deeper,
> so I'm not sure the fixups are the way to go.
>
> Now lets talk about design level stuff. Currently the assignment
> operations are designed in to accommodate the FCFS principle. This
> is a blessing and a curse at the same time.
>
> Consider the following scenarios. We have an empty (nothing assigned
> mdev) and the following queues are bound to the vfio_ap driver:
> 0.0
> 0.1
> 1.0
> If the we do
> asssign_adapter 0
> assign_domain 0
> assign_domain 1
> assign_adapter 1
> We end up with the guest_matrix
> 0.0
> 0.1
> and the matrix
> 0.0
> 0.1
> 1.0
> 1.0
>
> That is a different result compared to
> asssign_adapter 0
> assign_domain 0
> assign_adapter 1
> assign_domain 1
> or the situation where we have 0.0, 0.1, 1.0 and 1.1 bound to vfio_ap
> and then 1.1 gets unbound.

In v11 of the patch series, the filtering code always filters
the matrix assigned to the mdev and is invoked whenever
an adapter or domain is assigned, a queue is probed and
when the AP bus scan complete notification is received and
adapters and/or domains have been added to the host AP
configuration. So I made a slight modification to that
filtering function to filter only by APID and ran the above
scenarios. In each case, the resulting guest matrix was
identicle. I also tested the bind/unbind and achieved the
same results.

>
> For the same system state (bound, config, ap_perm, matrix) you get a
> different outcomes (guest_matrix), because the outcomes depend on
> history.
>
> Another thing is recovery. I believe the main idea behind shadow_apcb
> is that we should auto recover once the resources are available again.
> The current design choices make recovery more difficult to think about
> because we may end up having either the apid or the apqi filtered on
> a 'hole' (an queue missing for reasons different than, belonging to
> default, or not being in the host config).

The filtering code from the v11 series with the tweak I
mentioned above accomplishes this. I tested this by
doing manual binds/unbinds of a queue using the
scenarios you layed out.

>
> I still think for these cases filtering out the apid is the lesser
> evil. Yes a hotplug of a domain making hot unplugging an adapter is
> ugly, but at least I can describe that. So I propose the following.
> Let me hack up a fixup that morphs things in this direction. Maybe
> I will run into unexpected problems, but if I don't then we will
> have an alternative design you can run your testcases against. How about
> that?

I appreciate the offer, but I believe with the change to the v11
filtering code I described above we have a solution. One of
your objections to the filtering code was looping over all
assigned adapters/domains each time an adapter or
domain is assigned. It should also be easy to examine only
the APQNs involving the new APID or APQI being assigned.
Again, I appreciate your offer, but I don't think it is necessary
to take you away from your priorities to involve yourself in
mine.




>
> Regards,
> Halil
