Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B50EB64D7
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jun 2023 15:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFZPWa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFZPW2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 11:22:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24210CC
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 08:22:22 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QFHAJi032194;
        Mon, 26 Jun 2023 15:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gu6QTqCOiYKwVdMS0l8T4byBxyvItowib9qbQFmOCww=;
 b=rKiW0SZgQzYZJK63xSHBMqhP9FxqwjC2AHL2SH4dnAHyhSy8xAYmDZtgG7SC1KX/d7yw
 NeZNs+bTad7ksLcOFVwnvryIPqmbown6U0YZe6y5Cz+qsjt4Ds8iHsA4DI1WLTBWcj8K
 UIWXpucY5E3plFPER7zmEwMSzXcHLpr5cK8rgklgYeqc4BVDttSXtnrWTS6rweUMxNVN
 N2aVXgn4jO14Ow2PaIT0b+VEK0gVvVD7Z1GK5jQnC1fTGy7YKzy5naeNUjP5iWPpDi5Z
 cEte2wLZ1dC8Q1ohOEM/e9+ENgop0u+A9RpwiGiVWryg5lnBrEOxYD1C5soCZaMej1F5 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfd66845g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:22:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35QFHreZ002185;
        Mon, 26 Jun 2023 15:22:21 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfd66844c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:22:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q465rC017499;
        Mon, 26 Jun 2023 15:22:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr45105h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:22:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35QFMEWV45679086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 15:22:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 790702004B;
        Mon, 26 Jun 2023 15:22:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D1E320040;
        Mon, 26 Jun 2023 15:22:14 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Jun 2023 15:22:14 +0000 (GMT)
Date:   Mon, 26 Jun 2023 17:22:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: prospective 13/12 s390 pgtable_list patch
Message-ID: <ZJmtJEj/kgGS7B0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
 <ZJVl7ZJiborhmtYh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <232e20a5-ef6-41cf-4073-92fcb3a01453@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <232e20a5-ef6-41cf-4073-92fcb3a01453@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W480aRFAR6FrctYk1McUjPUH9--MXXEx
X-Proofpoint-ORIG-GUID: IFMjoGrDSnVwSPfsxh0d7SzOq4Ne0hAt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_12,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260136
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 23, 2023 at 01:53:43PM -0700, Hugh Dickins wrote:
> > Anyway, that is just another option and I will try your patch.
> 
> Thank you, please do, if you have the time: my series does need some
> kind of s390 solution, depending on whatever s390 has in its tree at
> the time: for now I should at least be showing the 13/12 (preferably
> known to build and appearing to work!), even if all it does is help
> people to say "no, that's too much".

Hi Hugh,

I took a bit different approach to run it: with and withough HH bits
in play.

IOW (if I am not mistaken) without the three patch serieses these two
patches on top of v6.4-rc5 alone still should manage page allocation,
as if pte_free_defer() does not exist/never get called:

	s390: add pte_free_defer() for pgtables sharing page
	prospective 13/12 s390 pgtable_list patch

These patches appear to work (aka survive LTP MM tests).

The next step would be to try the three serieses on top of v6.4-rc5 plus
patch 13/12, as you intended:

https://lore.kernel.org/linux-mm/77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com/
https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com/
https://lore.kernel.org/linux-mm/54cb04f-3762-987f-8294-91dafd8ebfb0@google.com
https://lore.kernel.org/r/a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com

I had to manually tweak this one with a fuzz in order to circumvent 'git am' error:
[PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to fail: fix

But in the end it still does not compile for me:

mm/memory.c: In function ‘zap_pmd_range’:
mm/memory.c:1561:21: error: implicit declaration of function ‘pmd_none_or_trans_huge_or_clear_bad’ [-Werror=implicit-function-declaration]
 1561 |                 if (pmd_none_or_trans_huge_or_clear_bad(pmd))
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      fs/btrfs/dev-replace.o
In file included from ./include/linux/build_bug.h:5,
                 from ./include/linux/container_of.h:5,
                 from ./include/linux/list.h:5,
                 from ./include/linux/smp.h:12,
                 from ./include/linux/kernel_stat.h:5,
                 from mm/memory.c:42:
mm/memory.c: In function ‘do_anonymous_page’:
mm/memory.c:4058:22: error: implicit declaration of function ‘pmd_trans_unstable’; did you mean ‘pud_trans_unstable’? [-Werror=implicit-function-declaration]
 4058 |         if (unlikely(pmd_trans_unstable(vmf->pmd)))
      |                      ^~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
  CC      fs/xfs/xfs_iops.o
mm/memory.c: In function ‘finish_fault’:
mm/memory.c:4388:13: error: implicit declaration of function ‘pmd_devmap_trans_unstable’; did you mean ‘pud_trans_unstable’? [-Werror=implicit-function-declaration]
 4388 |         if (pmd_devmap_trans_unstable(vmf->pmd))
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
      |             pud_trans_unstable


Could you please let me know if I am missing something?

Thanks!

> Hugh
