Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A7C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A7B610E7
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 17:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJLRVT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:21:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231756AbhJLRVP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 13:21:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CGb4vg000742;
        Tue, 12 Oct 2021 13:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jd9UyTmLqHs4rC9zO3ufWkJlFKNg7LlkKwuMV7wclLc=;
 b=LGJVOppeqFlgVUvQE+OR4AdLfwNPN9DU3rfVbv5rAZMbleYV/kimfZ0hc4k5Zo1YnHJz
 u4coE++EKh8IimDYL2MVNwVBy+FM/DzcQ/Llwz9romGmGsI8tqgPdzxPuDB6zmLy+62c
 80ZoMYXtZgm37HPfhJPX/b+ECXWIce7P+yjVYEaSJZwBKcHZkCHF/Rf0gvMpcYlComQM
 /9DOhW5cz0OwEcNP6nzF0+D26CWyaUh0J1N1JegUzsd0NKMS5obgrBJXMefGnBCkK50V
 xQMullgLDPDDIkxp8t5RbW/N0hXJQHxhHrmhS+8tll2D4mokVvCzyKrBQ30I/VhYulSv tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnakff8kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:18:50 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CGfa1h016068;
        Tue, 12 Oct 2021 13:18:49 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnakff8jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:18:49 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CHHN5r010428;
        Tue, 12 Oct 2021 17:18:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9k4k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 17:18:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CHIiNb46268824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 17:18:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BAEEA4059;
        Tue, 12 Oct 2021 17:18:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 425AFA405F;
        Tue, 12 Oct 2021 17:18:44 +0000 (GMT)
Received: from osiris (unknown [9.145.95.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Oct 2021 17:18:44 +0000 (GMT)
Date:   Tue, 12 Oct 2021 19:18:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <YWXDcoQEVm1uCCEP@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
 <20211012094852.7f6a59b8@gandalf.local.home>
 <YWWithSCGThguq7s@osiris>
 <20211012113404.29ac7c9c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012113404.29ac7c9c@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XELP0GaKTR8VkHLgi2JPf2Y1T6ApLpmU
X-Proofpoint-ORIG-GUID: HeOwK_v4gq0HApu3O-uV1rn4qGdnM_AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_04,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxlogscore=800 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 11:34:04AM -0400, Steven Rostedt wrote:
> On Tue, 12 Oct 2021 16:59:02 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > One thing to note: Jiri adds a new a sample module, which obviously
> > will not compile for s390. Not sure if the config mechanism I propose
> > with this patch set is the best way to address this - it would then
> > require to add a config option for each new sample module.
> 
> Is that really an issue?
> 
> We could just group them, as long as they have the same prefix.
> 
> HAVE_SAMPLE_FTRACE_DIRECT
> HAVE_SAMPLE_FTRACE_MULTI_DIRECT

Sure, works for me. I just thought I should mention this.
