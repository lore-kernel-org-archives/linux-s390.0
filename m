Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6682C4320A
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 21:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B774260EB5
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHSVnF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 17:43:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9902 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233664AbhHSVnE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 17:43:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JLbhS9023032;
        Thu, 19 Aug 2021 17:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pDJ23b0T59xqDtcuGq5YK+/9Dh/k4Y1+7c55NFrMeOA=;
 b=UU2qxKK9YYTfGc0M1DnoKj+LdveAv6puANB8TnKt661aIIaCylwc8+eWCTzjFVoF3mia
 1xRrmZSkk2eznQgCcCea60ktdI4tGgwFwuQ/83eIyt6wDx6VMJHfrVG7WH5GHd1ZGA2M
 wwhLT8C2e3EPS28NP6FI/F7B3FBNRaf5XCycWhB23Xda7WCnAM0KVKmWrw78dDuMjfsL
 s1usernD4Ap3rhk9UOgWFf5WiIwb/bSSHzKz8R2sqEkhZS7mHi/XfELjueyz/buWQgIm
 oqdqKAR3+xz9A16cFgqYpS1+phU/kX4PaE2FrYnOnv/1SslY7Wb6sdO6t/40OEMpDKmb Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahpr80x7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 17:42:26 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JLbnmg023649;
        Thu, 19 Aug 2021 17:42:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahpr80x7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 17:42:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JLQhor015747;
        Thu, 19 Aug 2021 21:42:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3ae5f8fktg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 21:42:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JLgJJH53215602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 21:42:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC37B5205F;
        Thu, 19 Aug 2021 21:42:18 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.32.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 5B8D652059;
        Thu, 19 Aug 2021 21:42:16 +0000 (GMT)
Date:   Thu, 19 Aug 2021 23:42:12 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
Message-ID: <20210819234212.7e21f699.pasic@linux.ibm.com>
In-Reply-To: <8df389f7-44aa-978e-84d8-96c625b0470b@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-2-akrowiak@linux.ibm.com>
        <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
        <20210819012532.0e9c443c.pasic@linux.ibm.com>
        <8df389f7-44aa-978e-84d8-96c625b0470b@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pc6Dk0SNbx_TCt-H5Mi9RWdSzgAKfRZ6
X-Proofpoint-ORIG-GUID: BMyeWgeo24tkrlvkd4CxY9ybL_Asb2RP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_07:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 19 Aug 2021 09:36:34 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >>>    static int handle_pqap(struct kvm_vcpu *vcpu)
> >>>    {
> >>>    	struct ap_queue_status status = {};
> >>> +	crypto_hook pqap_hook;
> >>>    	unsigned long reg0;
> >>>    	int ret;
> >>>    	uint8_t fc;
> >>> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> >>>    	 * Verify that the hook callback is registered, lock the owner
> >>>    	 * and call the hook.
> >>>    	 */
> >>> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
> >>>    	if (vcpu->kvm->arch.crypto.pqap_hook) {                     <--- HERE
> >>> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> >>> -			return -EOPNOTSUPP;
> >>> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> >>> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> >>> +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;  
> >> Dont we have to check for NULL here? If not can you add a comment why?  
> > I believe we did the necessary check on the line I just marked with
> > "<--- HERE".
> >
> > I find that "*" operator confusing in this context as it doesn't do
> > any good for us. I believe this situation is described in 6.5.3.2.4 of
> > the c11 standard. For convenience I will cite from the corresponding
> > draft:
> > "The unary * operator denotes indirection. If the operand points to a
> > function, the result is a function designator; if it points to an
> > object, the result is an lvalue designating the object. If the operand
> > has type ‘‘pointer to type’’, the result has type ‘‘type’’. If an
> > invalid value has been assigned to the pointer, the behavior of the
> > unary * operator is undefined."
> >
> > Frankly I also fail to see the benefit of introducing the local variable
> > named "pqap_hook", but back then I decided to not complain about style.  
> 
> The vcpu->kvm->arch.crypto.pqap_hook is a pointer to a function
> pointer. The actual function pointer is stored in matrix_mdev->pqap_hook,
> the reason being that the handle_pqap function in vfio_ap_ops.c
> retrieves the matrix_mdev via a container_of macro. The dereferencing
> of the vcpu->kvm->arch.crypto.pqap_hook into a local variable was
> to get the function pointer. There may have been a more stylish
> way of doing this, but the functionality is there.

You are right, and I was wrong. But then we do have to distinct pointer
deferences, and we check for NULL only once.

I still do believe we do not have a potential null pointer dereference
here, but the reason for that is that vfio-ap (the party that manages
these pointers) guarantees that whenever
vcpu->kvm->arch.crypto.pqap_hook != NULL is true, 
*vcpu->kvm->arch.crypto.pqap_hook != NULL is also true (and also that
the function pointer is a valid one). Which is the case, because we
set matrix_mdev->pqap_hook in vfio_ap_mdev_create() and don't touch
it any more.

In my opinion it is worth a comment.


> 
> >
> > Regards,
> > Halil
> >  
> >>  
> >>> +		ret = pqap_hook(vcpu);

BTW the second dereference takes place here.

If we wanted, we could make sure we don't dereference a null pointer
here but I think that would be an overkill.

Regards,
Halil  
> >> [...]  

