Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B4C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FE360ED4
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhJLS1p (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:27:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232880AbhJLS1o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 14:27:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CHfnlW005523;
        Tue, 12 Oct 2021 14:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=HjljicUc8K4UWNb9V2Ad2P6lDN0azjF8+m9yoIs2cXc=;
 b=YSun5YxscLaQtZFHc5+VakSZ97dWSB6oAgqK+VbzofmN/1DrcR4ngbLuoDdBKpnWpYrs
 yI2epWEL2Ua989Q7tc2Kz4OvxuKxEeBUW1bbfHWSHIs4TvNR55qLvXLH+Vfd5fyNKpro
 R7aPsfSz8hJ/WoWzyatxmZ85rziA93VTiEDdHF7cB1h4Je97irtPRPb9axFqB4l1nLF+
 iLcsd6IiyFgS7l3eOVPX2a91GUyv6cMCfrjunZ2UpSw6bNgSaCOg5vtf+y9NFYWyYus7
 Q/DouPBxSmpwzHgoYWCB5Oeu1Cc/YggM1Z196IcdXEeV+NUm/V8CEvrNzWhZprxe107r ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnf018vkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 14:25:20 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CHh6h0008318;
        Tue, 12 Oct 2021 14:25:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnf018vk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 14:25:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CINPnG015496;
        Tue, 12 Oct 2021 18:25:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qa3jgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 18:25:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CIJeEs64487816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 18:19:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 342ED4C058;
        Tue, 12 Oct 2021 18:25:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D60924C044;
        Tue, 12 Oct 2021 18:25:15 +0000 (GMT)
Received: from osiris (unknown [9.145.95.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Oct 2021 18:25:15 +0000 (GMT)
Date:   Tue, 12 Oct 2021 20:25:14 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <YWXTCm2S8WFIZKbh@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
 <20211012094852.7f6a59b8@gandalf.local.home>
 <YWWithSCGThguq7s@osiris>
 <YWXANRbkPIE3HtOE@krava>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWXANRbkPIE3HtOE@krava>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wXpCcBTUryJED5_ym5X2ycw3TaGgK5Az
X-Proofpoint-ORIG-GUID: fGjxMn0CqYkSsvc_NxiDFum5QzUXB1kD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_04,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=870 malwarescore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 07:04:53PM +0200, Jiri Olsa wrote:
> > > See here:
> > > 
> > >   https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/
> > 
> > I applied Jiri's patch set and the newly added selftest passes.
> 
> nice, could I have your Tested-by? ;-)

Well, now I added also the missing pieces to ftrace-direct-multi
sample module and when loading that and looking into
/sys/kernel/debug/tracing/trace it looks like "my_direct_func" gets
some random junk as parameter and nothing that could count as "ip".

Will look into that, probably tomorrow.
