Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6688C77B7F
	for <linux-s390@archiver.kernel.org>; Mon,  8 May 2023 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjEHQ6I (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 May 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjEHQ6H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 May 2023 12:58:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D34EFB
        for <linux-s390@vger.kernel.org>; Mon,  8 May 2023 09:58:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348GlvcX022913;
        Mon, 8 May 2023 16:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ItItWoQnsLsuHMJgYw8gV3/xhYnZJVcdqAF9hGhEFiI=;
 b=fWSD+o1AYvfyHkijHbGSKP9FFxcGzOEAVeiG1VTs9qT4NZv83Fpktgk17hTrz4CGipiA
 wZFWSE65W2sFFH5KUnTU2FUh6sIW9ewYy588I6h20j6BrjJP7QoeP9ziby6zA/Z181xr
 4Nh5GYBu7BAaM66YGTTzLMgnRqp9ohc1gAN2xnU8RfrB3TYr4NSY55Kn8wkIm+1St+xJ
 PkaXrJx+krPIm2Tub4WGffBjfR53nPFHiAUKSbqYIATVROeJzvOemBYtC4w4EPuoqb0l
 QwCCpU756LGdxZvDbXFEc8/nWEUEvII7Dx5JUPq5dQlcN0lTcSYCuhGCgmCV/7WrqDYa sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf4wxg7mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 16:57:51 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 348GqtCq006692;
        Mon, 8 May 2023 16:57:51 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf4wxg7k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 16:57:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3481pojU023497;
        Mon, 8 May 2023 16:57:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qdeh6h133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 16:57:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 348GvigQ8389266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 May 2023 16:57:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 474F620043;
        Mon,  8 May 2023 16:57:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A46B120040;
        Mon,  8 May 2023 16:57:43 +0000 (GMT)
Received: from osiris (unknown [9.171.72.156])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  8 May 2023 16:57:43 +0000 (GMT)
Date:   Mon, 8 May 2023 18:57:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [linux-next:master 14680/14811] mm/filemap.c:4250:1: sparse:
 sparse: Using plain integer as NULL pointer
Message-ID: <ZFkqBteEnMxRjUfj@osiris>
References: <202305070840.X0G3ofjl-lkp@intel.com>
 <CAKEwX=MrPCPKF7Yxfjc-uOR2P-+Ee8+RV_B_u1f7iqC0L=_yew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MrPCPKF7Yxfjc-uOR2P-+Ee8+RV_B_u1f7iqC0L=_yew@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BKayuXYXVjDh3dxCDCI7ZUV-QxTAHaPV
X-Proofpoint-ORIG-GUID: tvBe10K9EcBk6Rs1rEKDyqtH9FCgADgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 08, 2023 at 09:45:56AM -0700, Nhat Pham wrote:
> On Sat, May 6, 2023 at 5:28 PM kernel test robot <lkp@intel.com> wrote:
> > sparse warnings: (new ones prefixed by >>)
> >    mm/filemap.c:1416:17: sparse: sparse: context imbalance in 'migration_entry_wait_on_locked' - unexpected unlock
> > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL pointer
> > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL pointer
> > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL pointer
...
> > > 4250  SYSCALL_DEFINE4(cachestat, unsigned int, fd,
> 
> Hmm I couldn't see where I used 0 as the null pointer. Maybe
> this is a false positive or a result of not wiring up the syscall
> for s390? Especially since this is pointed toward the macro
> line (SYSCALL_DEFINE).
> 
> cc-ing this to s390 maintainers and the s390 mailing list...
> Could you help me debug this? Thanks!

Just ignore, this is a known false positive with s390's SYSCALL_DEFINE()
implementation vs sparse. I looked into it once, but couldn't figure out
how to silence sparse.
IIRC, the __TYPE_IS_PTR() macro causes this.
