Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A3DC25B47
	for <linux-s390@archiver.kernel.org>; Fri, 27 Oct 2023 10:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjJ0KKv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 Oct 2023 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0KKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Oct 2023 06:10:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674AD10E;
        Fri, 27 Oct 2023 03:10:45 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R9WQej010442;
        Fri, 27 Oct 2023 10:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Zdppxo1TCnt1+1WH+y7YV+bUn+8htX5Iub4/UTKYWm4=;
 b=on/HTgOAdS4zFn4b5OKS/+QUk1oy24KdZ2S14TDqgLY9BJ4ZJhyMjs8SfZatQ2Y/RP+/
 mqfYPD7FYi3/iPUAaOiftyawZissO6JZ4989afKf9xGHSP5ic1raa21xQDhniLv/V7JE
 zcEdkOlSuUW/EVLNVpDDUMjMh6+SSExtcPv7b3Y3BrEzD79mkWxglRGVopd6BSH0Z1We
 dPGfvEjSS5yg4rjCgAy/uaSB30rI82HAkXNA3KtSAu8rjkLmRVq6nWsSnPtAK2GGSw4G
 PVgUjs5uA/I1vKzc+G3s07RBvOxnHRgZ/IPkNSQQ8t31nvC+9mt8Je+OBvIQEoC9yW23 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0anp96hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:10:35 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R9o9Bn004880;
        Fri, 27 Oct 2023 10:10:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0anp94yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:10:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39R7h9Jc011857;
        Fri, 27 Oct 2023 10:09:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqr486r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:09:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39RA9RlR44630662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 10:09:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 719DA20067;
        Fri, 27 Oct 2023 10:09:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C476920049;
        Fri, 27 Oct 2023 10:09:26 +0000 (GMT)
Received: from osiris (unknown [9.171.25.10])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Oct 2023 10:09:26 +0000 (GMT)
Date:   Fri, 27 Oct 2023 12:09:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "dcavalca@meta.com" <dcavalca@meta.com>, ngompa@fedoraproject.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: s390x stack unwinding with perf?
Message-ID: <20231027100925.9071-B-hca@linux.ibm.com>
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
 <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zRSqztLHIpZI_t0IceHuvxdPJ0xSOB8V
X-Proofpoint-ORIG-GUID: X8YHzSy_NMYz8F7GQ5W8H0P2EvPIFxOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_08,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=529 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> 
> If the kernel gets support for s390x user space unwinding using the backchain,
> we'll propose to enable -mbackchain in the default compilation flags for Fedora
> so that s390x on Fedora will have the same profiling experience as x86-64, arm64
> and ppc64. For now we'll keep the status quo since compiling with the backchain
> doesn't provide any benefit until the kernel unwinder can unwind user
> space stacks
> using it.
> 
> Thanks for clarifying the current state of user space stack unwinding on s390x!

We will implement the missing pieces and let you know when things are
supposed to work.
