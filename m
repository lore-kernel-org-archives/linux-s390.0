Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E827C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BE060E09
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 08:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhETIkB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 04:40:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhETIkA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 04:40:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K8XDtV023760;
        Thu, 20 May 2021 04:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wpXekIV/UPMz8BLa3JAYJTIG7KK70tawDEsEuFrWSSk=;
 b=g1OYC8XKsOEo7j+kpW/oyGeBcuBbFql9FbSDiGyZh3WrWF4nYoqK3ByVe1iDl5JegBAf
 ueqr+owZXvou1A99SuULwIzItYizgDsO89bUc7rDU8dMWSrJcf7y7XJp7+dGYk0wuwmx
 2RfSk7hwz/mU46uSO4CJ0QCVKVMDS5UIRJBkXP9yKqM9tcTtnX+N2PSp0Sd+t9lGGBJy
 T0XaCPtpG/Ml3DsS9IjrUHqGPSSPAzOCFyoHutfiMVmuH9j4p2rCs4LaM8hjO8XWI3HO
 AaiRs0UkMDx0aiNCwIDVwPNCN50A31s5RnDnJ6n3m32eovyOspy99YqYjuYIhe/q+axM QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nm7j8byn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 04:38:38 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14K8XKtW024615;
        Thu, 20 May 2021 04:38:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nm7j8bxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 04:38:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14K8cZ7n032593;
        Thu, 20 May 2021 08:38:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 38j5x7th08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:38:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14K8c4s536438360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 08:38:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F9811C04A;
        Thu, 20 May 2021 08:38:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAC6811C054;
        Thu, 20 May 2021 08:38:31 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.68.61])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 20 May 2021 08:38:31 +0000 (GMT)
Date:   Thu, 20 May 2021 10:38:29 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210520103829.0913b6de.pasic@linux.ibm.com>
In-Reply-To: <20210519232202.GV1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
        <20210519153921.804887-3-akrowiak@linux.ibm.com>
        <20210519161610.GO1002214@nvidia.com>
        <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
        <20210519232202.GV1002214@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uN5TwIoE8WAWJl3BpyiCrLb-sSF85HyQ
X-Proofpoint-ORIG-GUID: l7VL1aB6qaYmCVIVvGCjwbIvE7hxXZKb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_01:2021-05-20,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 19 May 2021 20:22:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 19, 2021 at 07:04:46PM -0400, Tony Krowiak wrote:
> > 
> > 
> > On 5/19/21 12:16 PM, Jason Gunthorpe wrote:  
> > > On Wed, May 19, 2021 at 11:39:21AM -0400, Tony Krowiak wrote:
> > >   
> > > > @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> > > >   	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> > > >   		return -EOPNOTSUPP;
> > > > -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> > > > -	mutex_lock(&matrix_dev->lock);
> > > > +	rcu_read_lock();
> > > > +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
> > > > +	if (!pqap_module_hook) {
> > > > +		rcu_read_unlock();
> > > > +		goto set_status;
> > > > +	}
> > > > -	if (!vcpu->kvm->arch.crypto.pqap_hook)
> > > > -		goto out_unlock;
> > > > -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
> > > > -				   struct ap_matrix_mdev, pqap_hook);
> > > > +	matrix_mdev = pqap_module_hook->data;
> > > > +	rcu_read_unlock();
> > > > +	mutex_lock(&matrix_dev->lock);  
> > > The matrix_mdev pointer was extracted from the pqap_module_hook,
> > > but now there is nothing protecting it since the rcu was dropped and
> > > it gets freed in vfio_ap_mdev_remove.  
> > 
> > Therein lies the rub. We can't hold the rcu_read_lock across the
> > entire time that the interception is being processed because of
> > wait conditions in the interception handler. Regardless of whether
> > the pointer to the matrix_mdev is retrieved as the container of
> > or extracted from the pqap_hook, there is nothing protecting it
> > and there appears to be no way to do so using RCU.  
> 
> RCU is a lock that should only be used for highly performance
> sensitive read work loads. 

This is not a highly performance sensitive read workload.

> It eliminates one atomic from a lock, but
> if you go on to immediately do something like try_module_get, which
> has an atomic inside, the whole thing is pointless (assuming
> try_module_get was even the right thing to do)

I'm not sure about this argument, or that RCU should be used only for
highly performance sensitive read workloads. Can you please elaborate on
the argument above and also put your statement in perspective with
https://lwn.net/Articles/263130/?

@Christian: Since you proposed RCU for this, I guess your opinion
does not align with Jason's.

> 
> Use a simple sleepable rwsem around the whole thing and forget about
> the module_get. Hold the write side when NULL'ing the pointer.
> 

Yes a simple sleepable lock would work, and we wouldn't need
get_module(). Because before the vfio_ap module unloads, it
sets all vcpu->kvm->arch.crypto.pqap_hook instances to NULL. So if
we know that vcpu->kvm->arch.crypto.pqap_hook then we know
that the still have valid references to the module.

> > > And, again, module locking doesn't prevent vfio_ap_mdev_remove() from
> > > being called. None of these patches should be combining module locking
> > > with RCU.  
> > 
> > Is there any other way besides user interaction with the mdev's
> > sysfs remove interface for the remove callback to get invoked?  
> 
> There are more options after my re-organizing series.
> 
> But I'm not sure why you ask in response to my point about module
> locking? Module locking is not really related to sysfs.
> 
> > If I try to remove the mdev using the sysfs interface while the
> > mdev fd is still open by the guest, the remove hangs until the
> > fd is closed.  
> 
> Yes, it will wait when the vfio_device is being destroyed.
> 
> > That being the case, the mdev release callback will get invoked
> > prior to the remove callback being invoked which renders this whole
> > debate moot. What am I missing here?  
> 
> AFAICT the control flow is such that release can immediately move on
> to remove on the same CPU without an additional synchronization. So
> the kfree can still race with the above.
> 
> But the more I look at this the wonkier it is.. The real issue is not
> the matrix_mdev, it is the whole vcpu->kvm->arch.crypto.pqap_hook
> 
> This is nonesense too:
> 
> 	if (vcpu->kvm->arch.crypto.pqap_hook) {
> 		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> 			return -EOPNOTSUPP;
> 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);


> 
> It should have a lock around it of some kind, not a
> try_module_get. module_get is not la lock.

I tend to agree. In fact I asked for a lock around it several times:
https://www.lkml.org/lkml/2019/3/1/260
https://lkml.org/lkml/2020/12/3/987
https://lkml.org/lkml/2020/12/4/994

But in my opinion RCU is also viable (not this patch). I think, I prefer
a lock for simplicity, unless it is not (deadlocks) ;).

Many thanks for bringing your perspective to this. I'm optimistic about
getting this finally addressed properly.

Regards,
Halil




