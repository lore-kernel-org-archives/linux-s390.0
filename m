Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C69C433C1
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A933619CB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhC3Omb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 10:42:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231344AbhC3Om1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Mar 2021 10:42:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UEYsJu087917;
        Tue, 30 Mar 2021 10:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QA7H5MVVrTQhEjHy1qS4HEFk81PKJ9zEPRLaF60nnFY=;
 b=BlJyfdUEAaLdf2Dvbp3bHLYnZzWcWqi8QelZmH9ElwCOSG+dFw339JpqWGGAmxGrakjD
 UTFmAVKf8hQE0/bapB0wXLgSazIFL/QfUpnNmLgWBvBtwFpiBNIymYh8N5J6mEuHkU4F
 wK3PYSX82DJqQvMZC/IABlehvAX5zUFk4mLLRigtPrvkUqZqFHpiEtCfsTwZc/GZHrB7
 VgcHguys86lQOPP4cD1RmUGsPyG3DNtBxHj3zMxRPUCXbHsa5GMoGrrHmF1KQLZcjBNC
 xb6+nJmp63ZWbHK/qaDSpPRsZXgUA9PRBirgC5oebIuLHe6/NJaooyYGg4HPo3KL7/Cx iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhssv32v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 10:42:08 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UEZH0J090959;
        Tue, 30 Mar 2021 10:42:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhssv31j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 10:42:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UEg5uL006510;
        Tue, 30 Mar 2021 14:42:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37hvb8jsmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 14:42:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UEfh7o35258624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 14:41:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8E174204B;
        Tue, 30 Mar 2021 14:42:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE3642049;
        Tue, 30 Mar 2021 14:42:02 +0000 (GMT)
Received: from thinkpad (unknown [9.171.41.230])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 30 Mar 2021 14:42:02 +0000 (GMT)
Date:   Tue, 30 Mar 2021 16:42:00 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
Message-ID: <20210330164200.01a4b78f@thinkpad>
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yi7JXdLMXSe_hitBLtZAibAOcjZOsg2N
X-Proofpoint-ORIG-GUID: qeRHACNgQgo-kf2zlYsY1JMCUCYB1sQR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_04:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 mlxlogscore=648 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300107
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 29 Mar 2021 11:33:06 -0700
Yang Shi <shy828301@gmail.com> wrote:

> 
> When the THP NUMA fault support was added THP migration was not supported yet.
> So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> THP migration has been supported so it doesn't make too much sense to still keep
> another THP migration implementation rather than using the generic migration
> code.  It is definitely a maintenance burden to keep two THP migration
> implementation for different code paths and it is more error prone.  Using the
> generic THP migration implementation allows us remove the duplicate code and
> some hacks needed by the old ad hoc implementation.
> 
> A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
> and NUMA balancing.  The most of them support THP migration except for S390.
> Zi Yan tried to add THP migration support for S390 before but it was not
> accepted due to the design of S390 PMD.  For the discussion, please see:
> https://lkml.org/lkml/2018/4/27/953.
> 
> I'm not expert on S390 so not sure if it is feasible to support THP migration
> for S390 or not.  If it is not feasible then the patchset may make THP NUMA
> balancing not be functional on S390.  Not sure if this is a show stopper although
> the patchset does simplify the code a lot.  Anyway it seems worth posting the
> series to the mailing list to get some feedback.

The reason why THP migration cannot work on s390 is because the migration
code will establish swap ptes in a pmd. The pmd layout is very different from
the pte layout on s390, so you cannot simply write a swap pte into a pmd.
There are no separate swp primitives for swap/migration pmds, IIRC. And even
if there were, we'd still need to find some space for a present bit in the
s390 pmd, and/or possibly move around some other bits.

A lot of things can go wrong here, even if it could be possible in theory,
by introducing separate swp primitives in common code for pmd entries, along
with separate offset, type, shift, etc. I don't see that happening in the
near future.

Not sure if this is a show stopper, but I am not familiar enough with
NUMA and migration code to judge. E.g., I do not see any swp entry action
in your patches, but I assume this is implicitly triggered by the switch
to generic THP migration code.

Could there be a work-around by splitting THP pages instead of marking them
as migrate pmds (via pte swap entries), at least when THP migration is not
supported? I guess it could also be acceptable if THP pages were simply not
migrated for NUMA balancing on s390, but then we might need some extra config
option to make that behavior explicit.

See also my comment on patch #5 of this series.

Regards,
Gerald
