Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CACC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 17:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLHRpo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:45:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24246 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235315AbhLHRpn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 12:45:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FJOcj026779
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 17:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=d7KDFc4FULdh/IxWUoWkOTyr0XNI43iIvN2bN5aJm+A=;
 b=h8uR610w/d73IKK7VUiJMuRM4oamMiihsehXmCSaM3m4ua5OC/yyxxokofFarZ7hGb+c
 BxF/IbNEnUcRAXV8j2MjSm61mYb09mYE5jCllEqp1fTkk5p553s+4c2XG/zkPkjvnnBo
 guasaY6c2eNbJEaq+4oORvdHv491fQwR+UjvucfvIgYJ/Zxr9NlTZW1sqxZRX43TmBeG
 DqBO3PJjmu3jLopZlEtOW9Ms8aqR5ijJZ5KYbeVjB7Q/EFYf4X6C2CjOdvzYBQvcpeIQ
 eXrowRb44iADNJ1ldLzmDvwPGwFJIqSU1jcSziJDICeA6KYliivE6wr/61vgwSzXlZTq ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cty82k20a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Dec 2021 17:42:10 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8Gmlvq019893
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 17:42:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cty82k1yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 17:42:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8HWtrM003771;
        Wed, 8 Dec 2021 17:42:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykjjdxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 17:42:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Hg6LY28705024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 17:42:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49668AE055;
        Wed,  8 Dec 2021 17:42:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28FB1AE04D;
        Wed,  8 Dec 2021 17:42:06 +0000 (GMT)
Received: from localhost (unknown [9.171.51.81])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 17:42:06 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     ltao@redhat.com, hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/kexec: handle R_390_PLT32DBL reloc entries in
 arch_kexec_do_relocs()
In-Reply-To: <20211208145930.1ab4ce50@rhtmp>
In-Reply-To: 
References: <20211208105801.188140-1-egorenar@linux.ibm.com>
 <20211208145930.1ab4ce50@rhtmp>
Date:   Wed, 08 Dec 2021 18:42:05 +0100
Message-ID: <8735n32dua.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xA6dWl2ZhLlK7-zVOtQW5e-d6jycIxaS
X-Proofpoint-GUID: ANJHE7FsUgx7n_LeQ_hFTIHTzBqsMNdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_07,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=766 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Philipp,

Philipp Rudo <prudo@redhat.com> writes:

> Hi Alexander,
>
> thanks for taking care of this so fast!
>
> My personal approach was slightly different (see below). The idea
> behind this was that arch_kexec_do_relocs is also used by others which
> might have a PLT. For them your approach would mean an ABI breakage. On
> the other hand in case the other users have the same problem they would
> need to handle it for themselves. Not sure what's the better approach.
>

I'm also fine with your proposal for the fix.

If i'm not mistaken, arch_kexec_do_relocs() is used in decompressor and
for purgatory at the moment, and both should have all relocs resolved.
Do we have more users of arch_kexec_do_relocs() ? That was the reason i
added the fix to arch_kexec_do_relocs().

Now i'm actually wondering why we don't have any issues with
decompressor, probably because we do the final link where all
PLT-relative addresses are fixed. Because i see plenty of R_390_PLT32DBL
in startup.o e.g.

Thanks for feedback
Regards
Alex 
