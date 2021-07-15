Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCAC07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 13:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855A961167
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 13:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGONr4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:47:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhGONry (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 09:47:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FDXQrx194288;
        Thu, 15 Jul 2021 09:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=89j+iXcqJQ66/ABNZWU6Ibb4jC9YJkVQfMgrDl98lJ4=;
 b=Pqu58iqGJ47geeZrjofKqwA9sTXEs4pfngRetgNn9Dm/9ag/FV1HcN+5TROIqw8NLZjx
 tQ2L2ApbhayLQYxG6sG1KhABpfei2pKbGlLA5K/sUGMuzVTAvFRigAdXRr0dbJ36LKO3
 Ki5+XKASKp4W3cV9EbccJ7s+QbLaa/A84WCxq8lAAZwg0Jk+CxhjaTPePEIsIY17d6a8
 pmntEBBjjYPrCa+bQeR6E2GgtObd+M1cScd1aRdvU714fh2lV0YwMHJsf0V5Wjs84qVD
 exLaFiFDoPkscex6raglTvYf3sZ8c8S8C1S1FISw6H92ZeTsNzxvC1xShP3yLrKW+o1W Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39tmn0b56a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 09:45:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FDXQO9194371;
        Thu, 15 Jul 2021 09:44:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39tmn0b543-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 09:44:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FDi4NR002850;
        Thu, 15 Jul 2021 13:44:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 39q2thaa3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 13:44:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FDistP35455436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 13:44:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E54EA4068;
        Thu, 15 Jul 2021 13:44:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 089E0A4054;
        Thu, 15 Jul 2021 13:44:53 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.60.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 15 Jul 2021 13:44:52 +0000 (GMT)
Date:   Thu, 15 Jul 2021 15:44:51 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210715154451.3f0c264e.pasic@linux.ibm.com>
In-Reply-To: <20210707154156.297139-1-akrowiak@linux.ibm.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9XL9JnXJnnQAa3FUpx6ldqBRlfMQDaTV
X-Proofpoint-ORIG-GUID: EZa8fsu2dd3DU8lDXcRg7hg3g_eKVCB2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  7 Jul 2021 11:41:56 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

First sorry for being this late with having a more serious look at the
code.


> @@ -270,6 +270,9 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>   * We take the matrix_dev lock to ensure serialization on queues and
>   * mediated device access.
>   *
> + * Note: This function must be called with a read lock held on
> + *	 vcpu->kvm->arch.crypto.pqap_hook_rwsem.
> + *


That is a fine synchronization for the pqap_hook, but I don't think it
is sufficient for everything.


>   * Return 0 if we could handle the request inside KVM.
>   * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>   */
> @@ -287,22 +290,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  		return -EOPNOTSUPP;
> 
>  	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> -	mutex_lock(&matrix_dev->lock);

Here you drop a matrix_dev->lock critical section. And then
you do all the interesting stuff. E.g.
q = vfio_ap_get_queue(matrix_mdev, apqn);
and
vfio_ap_irq_enable(q, status & 0x07, vcpu->run->s.regs.gprs[2]);.
Since in vfio_ap_get_queue() we do the check if the queue belongs
to the given guest, and examine the matrix (apm, aqm) I suppose
that needs to be done holding a lock that protects the matrix,
and to my best knowledge this is still matrix_dev->lock. It would
probably make sense to convert matrix_dev->lock into an rw_semaphore,
or to introduce a some new rwlock which protects less state in the
future, but right now AFAICT it is still matrix_dev->lock.

So I don't think this patch should pass review.

Regards,
Halil

> 
>  	if (!vcpu->kvm->arch.crypto.pqap_hook)
>  		goto out_unlock;
>  	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>  				   struct ap_matrix_mdev, pqap_hook);
> 
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> -
>  	/* If the there is no guest using the mdev, there is nothing to do */
>  	if (!matrix_mdev->kvm)
>  		goto out_unlock;
