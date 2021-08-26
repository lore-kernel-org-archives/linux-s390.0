Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE21C432BE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8711860240
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 10:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhHZKW5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:22:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233654AbhHZKW5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Aug 2021 06:22:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QA3ZI2069971;
        Thu, 26 Aug 2021 06:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=BVAN/xxzPVJWRFQ6uZqBrupRzm7MY9uQ5jme3chmPW4=;
 b=WyTz+0ymNfTalfG1BEE2ovrO210fqfWenLnzGCqWCaBVVRbDxcwETr2l239u6EytfUHI
 lXQ0EERa0zyXLnxIB71jftUKxM6MbB4jqVocVPNMJcHqQg/0y2dx9/sPDFSGliGfI6zE
 cj9hyh2EclUHvHF6Gar6JeVwimTVRADYp6QLL0XKNlT7SPz6e0oRuVn3q59Oc/szwNLN
 Db96Ey9Ij+LtoXxbWuehF1qPN68b3hHJ8RZqmSkJfpmnR6eZsM+BCSAAs0AiiNigrkJ6
 XZS8TfHRQ29u8LYlbkarf/6dcWBusp8xJXOgHDjhlSc8tX3G1rDVQmtkuSbiXBohW8XY iw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ap72pk9bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 06:22:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17QACsKS015509;
        Thu, 26 Aug 2021 10:22:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48h5re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 10:22:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17QAM2Kh55116276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 10:22:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA67011C131;
        Thu, 26 Aug 2021 10:22:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC22111C070;
        Thu, 26 Aug 2021 10:22:00 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Aug 2021 10:22:00 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com
Subject: Re: crash on s390 with SCHED_CORE=y
References: <yt9d35qwa82w.fsf@linux.ibm.com>
        <20210826100856.GA4353@worktop.programming.kicks-ass.net>
Date:   Thu, 26 Aug 2021 12:21:59 +0200
In-Reply-To: <20210826100856.GA4353@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 26 Aug 2021 12:08:56 +0200")
Message-ID: <yt9dy28o8q0o.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VdXlNgjOMbQv-FnGct052K5vr_K6WiLa
X-Proofpoint-ORIG-GUID: VdXlNgjOMbQv-FnGct052K5vr_K6WiLa
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_02:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=903 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260061
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Aug 26, 2021 at 11:06:31AM +0200, Sven Schnelle wrote:
>> [   25.044234]  [<00000001655b7534>] raw_spin_rq_lock_nested+0x5c/0xb8
>> [   25.044241]  [<00000001655d2cfc>] online_fair_sched_group+0x9c/0x1c0
>> [   25.044248]  [<00000001655e481c>] sched_autogroup_create_attach+0xdc/0x210
>
> Does:
>
>   https://lkml.kernel.org/r/162970967846.25758.333277155824309635.tip-bot2@tip-bot2
>
> help?

Indeed. Should have searched the ML before debugging... Feel free to add
my

Tested-by: Sven Schnelle <svens@linux.ibm.com>
