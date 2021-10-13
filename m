Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4FBC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0236109F
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 08:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhJMIvK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:51:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhJMIvK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 04:51:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D7KaHY022021;
        Wed, 13 Oct 2021 04:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=/xQeJeUmpJlJzCaD4xNAcQ4788Uct2qKLbjhRFnjppI=;
 b=JDn1+zwumLdHyTi3WmRf/u2ygAcKeV8ZSHrv/KR1+nt86Ay6HbaZzHiCMCJi1ZkZo28Z
 6OlsBgx2W7WIcoxq1mwpLOcDQrmhA3rkib/R/CnWAVsjb5lD0wYxVh3dWrMYHjc1Dula
 jAr2b2lncnFoBD8u8BhvcrJdCw/tNxzPCsIvZbURiDO0d96om7FIuDgBXeTsE+OpTGVZ
 3NLh+ka7/b2WKHU/m1fr+shSYYaNVh/JYadBaTSzh6hEOnUM5mn7Y1OtaCrr6QTnmOWD
 be9O2nODSTllUUtaZ4VYGldPPklCA99Ofi4GFwU/gA7Zt9Hin43qajx4YmZ4i1cNsK7z 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79d4va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 04:48:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19D6t5hh004374;
        Wed, 13 Oct 2021 04:48:32 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79d4um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 04:48:31 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19D8iESP028849;
        Wed, 13 Oct 2021 08:48:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3bk2bjppjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 08:48:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19D8mMf330540102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:48:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC77242045;
        Wed, 13 Oct 2021 08:48:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B81F42042;
        Wed, 13 Oct 2021 08:48:22 +0000 (GMT)
Received: from osiris (unknown [9.145.19.118])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Oct 2021 08:48:22 +0000 (GMT)
Date:   Wed, 13 Oct 2021 10:48:20 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <YWadVEtwt8+mWsWo@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
 <20211012094852.7f6a59b8@gandalf.local.home>
 <YWWithSCGThguq7s@osiris>
 <YWXANRbkPIE3HtOE@krava>
 <YWXTCm2S8WFIZKbh@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWXTCm2S8WFIZKbh@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8cCMGh8B41tzZsxOaLfuIHobmF-Z5UOe
X-Proofpoint-ORIG-GUID: i6e3rtHGX7nrW8M4BQpaE747vbSmy_dj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_02,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=944 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130057
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 08:25:14PM +0200, Heiko Carstens wrote:
> On Tue, Oct 12, 2021 at 07:04:53PM +0200, Jiri Olsa wrote:
> > > > See here:
> > > > 
> > > >   https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/
> > > 
> > > I applied Jiri's patch set and the newly added selftest passes.
> > 
> > nice, could I have your Tested-by? ;-)
> 
> Well, now I added also the missing pieces to ftrace-direct-multi
> sample module and when loading that and looking into
> /sys/kernel/debug/tracing/trace it looks like "my_direct_func" gets
> some random junk as parameter and nothing that could count as "ip".
> 
> Will look into that, probably tomorrow.

Ok, if I load the correct module, it even works. I had a bug in the
first version, fixed it, but still loaded the broken module to test
my changes. Clever me ;)

So it all works for me.
