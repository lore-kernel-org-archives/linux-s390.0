Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71AC64EC4
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 12:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCJMnD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 07:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCJMnB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 07:43:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DF422E
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 04:42:56 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ABt4H6004042
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0Hf73JZyPFp7maTUGFozaA9SmjUpkm1ZwF6N6+/v0jQ=;
 b=F4Cv9b7MJU0hoBkt9UNcQwHxcJMlnOWWp0Apkyh3vVl/uCJvLZQ6mAZWoHr9Uk71bC/z
 EmGa4DKFIqtKiDUjc8uYq2RJRnF9D0yWVUb44fZ/S/60SB2L/e9vb57/fujND8bKPJfJ
 LDOZCn8hQMJP6uxtIglVjzGDS+BfQn83GjZM2A2YsWHNu+3MjNGmbERut4Mdm+ymWi/D
 7GCdmdGtnY74V9Jqf/u8RqhzNEk9MejZoo1ld6OJK/xl4DTOfH3R30YiTcW6jZaWUyBt
 nmNoX6l7ZzyZNgWl19Ay7M0GSXVqtGzOj5c5XG5jqa9vagr3dsTcIAlhD4zuiHW8Agou 9w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p843ksae0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:42:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8o7KS003953
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:42:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p6g0jjvp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 12:42:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ACgolu34603664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 12:42:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B5020040;
        Fri, 10 Mar 2023 12:42:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3E52004B;
        Fri, 10 Mar 2023 12:42:49 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.36.141])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 12:42:49 +0000 (GMT)
Date:   Fri, 10 Mar 2023 13:42:47 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
Message-ID: <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230310122204.1898-1-nrb@linux.ibm.com>
 <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WodAHcwo_G-LWt4vfV1tSxQfyJGe4vmP
X-Proofpoint-ORIG-GUID: WodAHcwo_G-LWt4vfV1tSxQfyJGe4vmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=456 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 10, 2023 at 01:34:27PM +0100, Alexander Gordeev wrote:
> > Note that several callers pass NULL as addr, this is fine since
> > virt_to_phys(0) == 0.

Missed that.

Are you sure? Quickly checked ppc64, x86 and arm64 - they do not 
seem adhere virt_to_phys(0) == 0, nor the VR kernel (so far).
