Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DDC4332F
	for <linux-s390@archiver.kernel.org>; Thu,  9 Nov 2023 14:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjKIOsr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Nov 2023 09:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKIOsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Nov 2023 09:48:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02544358B;
        Thu,  9 Nov 2023 06:48:44 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9EBQgL027596;
        Thu, 9 Nov 2023 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=fvmIgIwuDDKyS4pBqm0Hr3TcpyXi7utCCFJNivbMx6U=;
 b=Sv//dap7LSeUEYlMU9HSEeUh+Ir0FxoI52oQP2Nv560vz5RvPVQc16Wz1mvjv7Jcc0aw
 RIRJHTYmHPFIjUVhsN8DjZcuG6tveZVLQlAdGik41KgPoSa0i23MJV4qAMuSy8W9PJwO
 26ImqAk/XfhMseANzrQyW9yDrOs3qqZyikQ1UxD9dSRVFJZvI29Cr9d71v/8wGEvebqU
 ocE4wBRU9IglcfinV8f1Drnqrald29Gv4WUUlY0VBN6Tn9roPUUHpThYQ32Zo1CWhZ5y
 wQn3XAsWJx3bduVPE+Dbw3qmYo1ReFSzeFqixv6ohM3EdGoz2w8ZjflaaGoqsbyTwfNV UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u90m7a3gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 14:48:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9EBjlv029375;
        Thu, 9 Nov 2023 14:48:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u90m7a3gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 14:48:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9EC9jU028302;
        Thu, 9 Nov 2023 14:48:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22mc7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 14:48:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A9EmagT8127224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 14:48:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE302004B;
        Thu,  9 Nov 2023 14:48:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4C220040;
        Thu,  9 Nov 2023 14:48:35 +0000 (GMT)
Received: from osiris (unknown [9.171.80.120])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Nov 2023 14:48:35 +0000 (GMT)
Date:   Thu, 9 Nov 2023 15:48:34 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Davide Cavalca <dcavalca@meta.com>
Subject: Re: s390x stack unwinding with perf?
Message-ID: <20231109144834.11754-B-hca@linux.ibm.com>
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
 <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com>
 <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
 <20231030123558.10816-A-hca@linux.ibm.com>
 <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kGkWAnjhBsUQvHZy1KXQGyy5A20FM_QM
X-Proofpoint-ORIG-GUID: OhYJXmbmRuzYdmlw01eCfTBrM3t3FhP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxlogscore=611 malwarescore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090112
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 30, 2023 at 09:19:02AM -0400, Neal Gompa wrote:
> On Mon, Oct 30, 2023 at 9:02 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 11:22:42AM -0400, Neal Gompa wrote:
> > > On Fri, Oct 27, 2023 at 6:10 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> > > >
> > > > On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> > > > >
> > > > > If the kernel gets support for s390x user space unwinding using the backchain,
> > > > > we'll propose to enable -mbackchain in the default compilation flags for Fedora
> > > > > so that s390x on Fedora will have the same profiling experience as x86-64, arm64
> > > > > and ppc64. For now we'll keep the status quo since compiling with the backchain
> > > > > doesn't provide any benefit until the kernel unwinder can unwind user
> > > > > space stacks
> > > > > using it.
> > > > >
> > > > > Thanks for clarifying the current state of user space stack unwinding on s390x!
> > > >
> > > > We will implement the missing pieces and let you know when things are
> > > > supposed to work.
> > >
> > > Do you think we could have an initial patch set for implementing the
> > > missing pieces in time for the Linux 6.8 merge window? Then we can
> > > look at enabling this for s390x as a Fedora Linux 40 Change.
> >
> > This will be very likely the case. Actually the plan is to go with the
> > patch below. I gave it some testing with Fedora 38 and replaced (only)
> > glibc with a variant that was compiled with -mbackchain.
...
> This patch LGTM. I'd love to see it land in Linux 6.7!
> 
> Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>

FWIW, this is now upstream and will land in 6.7, together with a similar
patch which adds user stacktrace support:

504b73d00a55 ("s390/perf: implement perf_callchain_user()")
aa44433ac4ee ("s390: add USER_STACKTRACE support")

Please let us know if there are any problems.
