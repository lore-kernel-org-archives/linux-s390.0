Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44DC07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 18:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB6A6127C
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 18:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhGMSuB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:50:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229500AbhGMSt7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 14:49:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DIYQOG191072;
        Tue, 13 Jul 2021 14:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rGyPh9dHcWjAxXdFjnsEc9dwbCIGHA68f2kvsmINWMA=;
 b=EQw3O0m5DNhPLd2Hfbar9vgdjhMNik5GDpankPvLuqS2eVf/DKW/XCPYU/3/ARQixKng
 iHCVxlIzwyA+m6+wHw68RXzRY7bmZpM8KoMGkOpKJIw79eJqqCR47/+FItTaUNVTX1/2
 WPVejvFLKZXFnLSwrv4nRCBtTkJVpVmj1jP5AMADO0yfxrF/+bCNu6/aV6EpisH2L/6q
 Ni+NkoOTF+mukdC9sAHvgYG+kDjEPmDEV++gCbRYzFnqKTHZHedmMoMmszlrshIcmdw9
 XraBY2cgMGNknW+AbTgQLgO9kzEz/b9RB53j81Ac+XGO9OE7Um9wqOxphwYEwfMDF/Wa qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sdy5mx16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 14:47:06 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16DIZSNb196082;
        Tue, 13 Jul 2021 14:47:05 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sdy5mx0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 14:47:05 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16DIjhCe005498;
        Tue, 13 Jul 2021 18:47:05 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 39q36ccyj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 18:47:05 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16DIl3cU34996500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 18:47:03 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9659D13604F;
        Tue, 13 Jul 2021 18:47:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 084B1136060;
        Tue, 13 Jul 2021 18:47:00 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jul 2021 18:47:00 +0000 (GMT)
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
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <29f8c92c-2ad9-b407-4063-0e9a4580c971@linux.ibm.com>
Date:   Tue, 13 Jul 2021 14:47:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210713184517.48eacee6.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WpgcrbO8Qxfzi0WiQrCVImz4Rnqqg8GS
X-Proofpoint-GUID: uV7ZPBNZDfwNcd86FYI4Z9cN4aCiuyLi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_10:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/13/21 12:45 PM, Halil Pasic wrote:
> On Tue, 13 Jul 2021 09:48:01 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 7/12/21 7:38 PM, Halil Pasic wrote:
>>> On Wed,  7 Jul 2021 11:41:56 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> It was pointed out during an unrelated patch review that locks should not
>>>> be open coded - i.e., writing the algorithm of a standard lock in a
>>>> function instead of using a lock from the standard library. The setting and
>>>> testing of the kvm_busy flag and sleeping on a wait_event is the same thing
>>>> a lock does. Whatever potential deadlock was found and reported via the
>>>> lockdep splat was not magically removed by going to a wait_queue; it just
>>>> removed the lockdep annotations that would identify the issue early
>>> Did you change your opinion since we last talked about it? This reads to
>>> me like we are deadlocky without this patch, because of the last
>>> sentence.
>> The words are a direct paraphrase of Jason G's responses to my
>> query regarding what he meant by open coding locks. I
>> am choosing to take his word on the subject and remove the
>> open coded locks.
>>
>> Having said that, we do not have a deadlock problem without
>> this patch. If you recall, the lockdep splat occurred ONLY when
>> running a Secure Execution guest in a CI environment. Since
>> AP is not yet supported for SE guests, there is no danger of
>> a lockdep splat occurring in a customer environment. Given
>> Jason's objections to the original solution (i.e., kvm_busy flag
>> and wait queue), I decided to replace the so-called open
>> coded locks.
> I'm in favor of doing that. But if   ("s390/vfio-ap: fix
> circular lockdep when setting/clearing crypto masks") ain't buggy,
> then this patch does not qualify for stable. For a complete set of
> rules consult:
> https://github.com/torvalds/linux/blob/master/Documentation/process/stable-kernel-rules.rst
>
> Here the most relevant points:
> * It must fix a real bug that bothers people (not a, "This could be a
> problem..." type thing).
> * t must fix a problem that causes a build error (but not for things
> marked CONFIG_BROKEN), an oops, a hang, data corruption, a real security
> issue, or some "oh, that's not good" issue. In short, something critical.
> * No "theoretical race condition" issues, unless an explanation of how
> the race can be exploited is also provided.
>
> Jason may give it another try to convince us that 0cc00c8d4050 only
> silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
> knowledge using condition variable and a mutex is one of the well known
> ways to implement an rwlock.
>
> In my opinion, you should drop the fixes tag, drop the cc stable, and
> provide a patch description that corresponds to *your* understanding
> of the situation.

I'll drop the fixes and cc stable. Given the patch was created in
response to Jason G's comments - which are paraphrased in
the patch description - the patch description corresponds
directly to my understanding of the situation. It is precisely why
I created the patch.

>
> Neither the Fixes tag or the stable process is (IMHO) meant for these
> types of (style) issues. And if you don't think the alleged problem is
> real, don't make the description of your patch say it is real.
> Regards,
> Halil
>
>>> Regards,
>>> Halil

