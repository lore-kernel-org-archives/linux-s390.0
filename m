Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F45C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 23:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5186109F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 23:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhHRX0T (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:26:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232862AbhHRX0T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 19:26:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IN2lrF085317;
        Wed, 18 Aug 2021 19:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=YTNqZyC2/6p5fS0FUwFAEPGP7neDfdKiHZy0ngFIL/k=;
 b=j6AUbCNUbVydMWeACew4Xj6rTTI0IjH02qAPc5NpO9QgqIoj/GbjG9nMOg/Cb19thpzP
 MXmdBBUoXPQ9W9RzL1E5rSN4ywItXlzfWP0mltxiYqAZRRQIn+b8EDjctF6iW9O+l19v
 RP7d2sehK50htM+AWrpveYTn4NFkLtGoknomuZJxbzUAjjMp7ZapsO6ty6lbW5wUEihq
 57LQLv5bPf9rONNdqzQVm+Yr9yIh3YC+/TI6To55Wbo5uiRayBEbtNLdkvxjwfEWXlHg
 nSUf5I6QOqZVc6uH7GYxwqHk5XapTdlUEt1xn+/kf9yfq6AaDSyXq6TroCSqrtZx/FJo FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agkvn69hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 19:25:42 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17INNLZF013191;
        Wed, 18 Aug 2021 19:25:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agkvn69gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 19:25:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IND7j7012827;
        Wed, 18 Aug 2021 23:25:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ae5f8fch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 23:25:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17INM8pO61538716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 23:22:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A63A4057;
        Wed, 18 Aug 2021 23:25:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62193A408C;
        Wed, 18 Aug 2021 23:25:35 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.56.174])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 18 Aug 2021 23:25:35 +0000 (GMT)
Date:   Thu, 19 Aug 2021 01:25:32 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
Message-ID: <20210819012532.0e9c443c.pasic@linux.ibm.com>
In-Reply-To: <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-2-akrowiak@linux.ibm.com>
        <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WWIhEEBxA1vwnxTFDOPVUJBuufTmYfbw
X-Proofpoint-GUID: 7gIiEgAPEFP-CyJY1rlqNG2_lfp2z9lv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_07:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180135
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 18 Aug 2021 19:03:33 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 19.07.21 21:35, Tony Krowiak wrote:
> > The function pointer to the interception handler for the PQAP instruction
> > can get changed during the interception process. Let's add a
> > semaphore to struct kvm_s390_crypto to control read/write access to the
> > function pointer contained therein.
> > 
> > The semaphore must be locked for write access by the vfio_ap device driver
> > when notified that the KVM pointer has been set or cleared. It must be
> > locked for read access by the interception framework when the PQAP
> > instruction is intercepted.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >   arch/s390/include/asm/kvm_host.h      |  8 +++-----
> >   arch/s390/kvm/kvm-s390.c              |  1 +
> >   arch/s390/kvm/priv.c                  | 10 ++++++----
> >   drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
> >   drivers/s390/crypto/vfio_ap_private.h |  2 +-
> >   5 files changed, 28 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> > index 9b4473f76e56..f18849d259e6 100644
> > --- a/arch/s390/include/asm/kvm_host.h
> > +++ b/arch/s390/include/asm/kvm_host.h
> > @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
> >   	unsigned short ibc;
> >   };
> >   
> > -struct kvm_s390_module_hook {
> > -	int (*hook)(struct kvm_vcpu *vcpu);
> > -	struct module *owner;
> > -};
> > +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
> >   
> >   struct kvm_s390_crypto {
> >   	struct kvm_s390_crypto_cb *crycb;
> > -	struct kvm_s390_module_hook *pqap_hook;
> > +	struct rw_semaphore pqap_hook_rwsem;
> > +	crypto_hook *pqap_hook;
> >   	__u32 crycbd;
> >   	__u8 aes_kw;
> >   	__u8 dea_kw;
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index b655a7d82bf0..a08f242a9f27 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
> >   {
> >   	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
> >   	kvm_s390_set_crycb_format(kvm);
> > +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
> >   
> >   	if (!test_kvm_facility(kvm, 76))
> >   		return;
> > diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> > index 9928f785c677..6bed9406c1f3 100644
> > --- a/arch/s390/kvm/priv.c
> > +++ b/arch/s390/kvm/priv.c
> > @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
> >   static int handle_pqap(struct kvm_vcpu *vcpu)
> >   {
> >   	struct ap_queue_status status = {};
> > +	crypto_hook pqap_hook;
> >   	unsigned long reg0;
> >   	int ret;
> >   	uint8_t fc;
> > @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> >   	 * Verify that the hook callback is registered, lock the owner
> >   	 * and call the hook.
> >   	 */
> > +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
> >   	if (vcpu->kvm->arch.crypto.pqap_hook) {                     <--- HERE
> > -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> > -			return -EOPNOTSUPP;
> > -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> > -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> > +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;  
> 
> Dont we have to check for NULL here? If not can you add a comment why?

I believe we did the necessary check on the line I just marked with
"<--- HERE". 

I find that "*" operator confusing in this context as it doesn't do
any good for us. I believe this situation is described in 6.5.3.2.4 of
the c11 standard. For convenience I will cite from the corresponding
draft:
"The unary * operator denotes indirection. If the operand points to a
function, the result is a function designator; if it points to an
object, the result is an lvalue designating the object. If the operand
has type ‘‘pointer to type’’, the result has type ‘‘type’’. If an
invalid value has been assigned to the pointer, the behavior of the
unary * operator is undefined."

Frankly I also fail to see the benefit of introducing the local variable
named "pqap_hook", but back then I decided to not complain about style.

Regards,
Halil

> 
> 
> > +		ret = pqap_hook(vcpu);  
> [...]

