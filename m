Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992BFC07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92561249
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 13:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhGMNu6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:50:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236222AbhGMNu6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 09:50:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DDY0A2160520;
        Tue, 13 Jul 2021 09:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EsizOuUYqgDJqD1SA7Gt1GBWWhLQK+pZApIq/X2FPt0=;
 b=f4DhsNap2KIW0/CBTL9Jx4qpOdO0cDRJE+pjdIYRAuI72RLDUtHl8iTm5+C+pCIzZr6N
 xn2afLQdDPfHz5mM2U68aHFQNr9CKBERPMKbtA3wgyYnQVgjWq2amzPKA0sXFZQ5PpZx
 sHvbU+WW9iGF/4JrlWDR3GT2FsdC9XDPe91j7V8YfxQRFcQCTRPAamKnwME3Cp1+qITL
 d1z0exy1/uzqJArltaLXB1QIwsdDOFCasux6Gv0Xdaj9sxqIa0Woh6L2tXy+GVcs9gYn
 6xYWkgiS1VFSNZUcObY5Wq3J9BI1+cD61fSwq+G0+Vr37F6uv0cgDLDf0GQz/l/xUzgH uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkwtjg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 09:48:06 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16DDYVZZ162068;
        Tue, 13 Jul 2021 09:48:06 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkwtjfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 09:48:06 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16DDcRLt000967;
        Tue, 13 Jul 2021 13:48:05 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 39q36bqwj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 13:48:05 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16DDm3wU25035152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 13:48:03 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D239E136051;
        Tue, 13 Jul 2021 13:48:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83AE613605E;
        Tue, 13 Jul 2021 13:48:02 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jul 2021 13:48:02 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
Date:   Tue, 13 Jul 2021 09:48:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210713013815.57e8a8cb.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sixkAA8Q_4Pda_6ejzfhPfwcZw7HzmuJ
X-Proofpoint-ORIG-GUID: mY_nBjNP8K7kfBpFx9cMs83BXdFgKZHd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_05:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130086
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/12/21 7:38 PM, Halil Pasic wrote:
> On Wed,  7 Jul 2021 11:41:56 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> It was pointed out during an unrelated patch review that locks should not
>> be open coded - i.e., writing the algorithm of a standard lock in a
>> function instead of using a lock from the standard library. The setting and
>> testing of the kvm_busy flag and sleeping on a wait_event is the same thing
>> a lock does. Whatever potential deadlock was found and reported via the
>> lockdep splat was not magically removed by going to a wait_queue; it just
>> removed the lockdep annotations that would identify the issue early
> Did you change your opinion since we last talked about it? This reads to
> me like we are deadlocky without this patch, because of the last
> sentence.

The words are a direct paraphrase of Jason G's responses to my
query regarding what he meant by open coding locks. I
am choosing to take his word on the subject and remove the
open coded locks.

Having said that, we do not have a deadlock problem without
this patch. If you recall, the lockdep splat occurred ONLY when
running a Secure Execution guest in a CI environment. Since
AP is not yet supported for SE guests, there is no danger of
a lockdep splat occurring in a customer environment. Given
Jason's objections to the original solution (i.e., kvm_busy flag
and wait queue), I decided to replace the so-called open
coded locks.

>
> Regards,
> Halil

