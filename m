Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F770C432BE
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60791606A5
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 17:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhHRREp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:04:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhHRRET (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 13:04:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IH3PYQ101051;
        Wed, 18 Aug 2021 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rEuWT4UhoOXF6FchikCv8NH2kVska2ycyMLBPtJR+Rs=;
 b=dzFPFMpkSSO03SRsPGheCkzVV/eWc4u0UZ6OSGLWWe/EGVKjeDY947ryEZEzxrwVbVxZ
 MNg9/pIg8n782xk21iR+jT5zz6GjJL8yGX8QTu3oBQMS5jDuw3ub6zhpjJxg1QKD/CZG
 wNFC2UCYUxEcC+aDaTFOYBKeu4iCyE5Wp2MsmztbxADnn1JDzCggRkH7blLUizGZsD+C
 N3/IZQi+f7XFEWrNgGHXAF8cjxIw9Lmra/YFXqEieIaA+FoSp0zyJdDBPynQbVle8Xsv
 tslyNIwn5w2Hr8/JO3TUGAErwhVelCyQ8NjquIV83KGoDheQ3PHyV4Kxo7v/36stS7cH fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcf6n8qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 13:03:40 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17IH3e8x102110;
        Wed, 18 Aug 2021 13:03:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agcf6n8q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 13:03:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IH2hJ5001154;
        Wed, 18 Aug 2021 17:03:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3agh2xhdjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 17:03:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17IH3YlD55574812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 17:03:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD4AD11C08E;
        Wed, 18 Aug 2021 17:03:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F0A511C06F;
        Wed, 18 Aug 2021 17:03:33 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.60.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Aug 2021 17:03:33 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
Date:   Wed, 18 Aug 2021 19:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719193503.793910-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8esBHBRvTeZXmToWV2rRtM8SKxuaFnPH
X-Proofpoint-GUID: N5nR6NEjY5Up8PX1REPUMZw0FYOi6x5g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_05:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180107
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.07.21 21:35, Tony Krowiak wrote:
> The function pointer to the interception handler for the PQAP instruction
> can get changed during the interception process. Let's add a
> semaphore to struct kvm_s390_crypto to control read/write access to the
> function pointer contained therein.
> 
> The semaphore must be locked for write access by the vfio_ap device driver
> when notified that the KVM pointer has been set or cleared. It must be
> locked for read access by the interception framework when the PQAP
> instruction is intercepted.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  8 +++-----
>   arch/s390/kvm/kvm-s390.c              |  1 +
>   arch/s390/kvm/priv.c                  | 10 ++++++----
>   drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>   5 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 9b4473f76e56..f18849d259e6 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> -struct kvm_s390_module_hook {
> -	int (*hook)(struct kvm_vcpu *vcpu);
> -	struct module *owner;
> -};
> +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
>   
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> -	struct kvm_s390_module_hook *pqap_hook;
> +	struct rw_semaphore pqap_hook_rwsem;
> +	crypto_hook *pqap_hook;
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index b655a7d82bf0..a08f242a9f27 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>   {
>   	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>   	kvm_s390_set_crycb_format(kvm);
> +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>   
>   	if (!test_kvm_facility(kvm, 76))
>   		return;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..6bed9406c1f3 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   static int handle_pqap(struct kvm_vcpu *vcpu)
>   {
>   	struct ap_queue_status status = {};
> +	crypto_hook pqap_hook;
>   	unsigned long reg0;
>   	int ret;
>   	uint8_t fc;
> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * Verify that the hook callback is registered, lock the owner
>   	 * and call the hook.
>   	 */
> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;

Dont we have to check for NULL here? If not can you add a comment why?

Otherwise this looks good.


> +		ret = pqap_hook(vcpu);
[...]
