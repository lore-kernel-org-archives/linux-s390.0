Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787FEB64D7
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jun 2023 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjF1TQD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:16:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60974 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbjF1TP5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jun 2023 15:15:57 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SJ1VVV003741;
        Wed, 28 Jun 2023 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=098SpukzCeWI3mNHgDVbhVRrENMoSXPLuFR6tTaDAws=;
 b=HJ+dfnA5ZIXz7CA8CqrKTsM/JuDkUtja2PXxLpWkmXAm2LvKPiNi6xkHU8JdQfPc+Nea
 LPda2UUPpJ2B0uJ2GmHJMam2zjek2JM7xRdldPIsK5o54MFsQudLlf9/N9d9s1CCxQR7
 GknxxdPm5F/9Jmm2aoCWT7rX8JkrfLejmpP02ZAHs/7DLpNQXSP79tdYfV2xL9a6aHne
 QVZUuM+njfuE0YqvAy+JmhyAeNL96nYyoIOcqEqAdW38BAdFQtKFmb/nDMDqQCVh6yHH
 CFQH11dnaHs3Wu9XBjuTvYA4wiGpaz+sDupgw37NI6mgfrbgbMziwSDONqXu4Ba17W6X PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgtnhrcrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:15:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SJ9EhG019660;
        Wed, 28 Jun 2023 19:15:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgtnhrckm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:15:53 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SI6nlc007785;
        Wed, 28 Jun 2023 19:15:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr4525bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:15:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SJFh8I66715978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 19:15:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055062004B;
        Wed, 28 Jun 2023 19:15:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D50620040;
        Wed, 28 Jun 2023 19:15:42 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.179.23.181])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 28 Jun 2023 19:15:42 +0000 (GMT)
Date:   Wed, 28 Jun 2023 21:15:39 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: prospective 13/12 s390 pgtable_list patch
Message-ID: <20230628211539.67e25131@thinkpad-T15>
In-Reply-To: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
References: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o5QlcC83QywJDDYV_WAYfaHdHJXRsZSb
X-Proofpoint-ORIG-GUID: fprCJS4bL2s1RTmX59191f1EECBmfEtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306280169
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 22 Jun 2023 22:49:43 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> Hi Gerald,
> 
> It's that moment you've been dreading: I'm hoping that you can, please,
> take a look at the patch below, and try building and running with it,
> on top of the v2 series of 12 I sent out on Tuesday.

Wow, not sure if this is now dreadful or awesome, it could be the latter
since this might actually work. But as Alexander already said, we would
rather not add more complexity, for an already questionable benefit with
regard to saving some page table memory.

I have revisited my last approach with not adding back fragments in the
pte_free_defer() path, and I am rather confident now that there is no
"list_del() without list_add()" flaw any more. I had to use the
page->pt_frag_refcount for this, to track list status. So even though we
do not need page->pt_mm any more, that union is still not free for other
things. But I guess that is acceptable, and I especially like that the
patch will almost not change existing code at all, apart from the list
status tracking.

See my reply to your patch 07/12 in the other thread, for the patch.
It is tested with LTP and patches from all three series applied, and
it would allow going further with your work by having some s390 solution,
that is neither obviously flawed, nor too complex to handle or understand
also in the future.

I also left a TODO comment in the patch, with regard to the still open
question if we need the gmap_unlink(mm, pgtable, addr) also in
pte_free_defer(), similar to page_table_free_rcu(). If yes, we would need
some way to pass along the addr, which should be possible. However, IIUC,
retract_page_tables() is currently ending up in a normal page_table_free(),
w/o your work. And there we also have no addr available, and do no
gmap_unlink(), so there might be a good chance that this is not needed here.
