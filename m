Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8294BC4708E
	for <linux-s390@archiver.kernel.org>; Mon,  2 Jan 2023 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjABU2q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Jan 2023 15:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjABU2U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Jan 2023 15:28:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB577B7C5
        for <linux-s390@vger.kernel.org>; Mon,  2 Jan 2023 12:28:19 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302J0Cck017987
        for <linux-s390@vger.kernel.org>; Mon, 2 Jan 2023 20:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gi8viNM7J6TbLmTSUx2Zkzbz8vnopxZWWalUyYo4p80=;
 b=RkpYS6y/wewSuW779SCqkbHHSzsSp0Ej0Xo07PMSTSnS48HRb2bM7HXAVsyU5CH6Zh5a
 D7HiL4XlUSXdCg391RtbaQB39N9cu/zdgoWE6JP/KUz+EuAsUF9Abh/aREN91XHoYRxX
 7QyDBitYNtkXh/IaC98IEof/plamApucYtAbjH48bWQh59AhdItyA64v8aNFl/dobm93
 Tjyo90V7I07dCcCw+2J3IT2oFRKw8ExEgJxAvqBswNrybZORxuQD+Q9YEZBYKeESFhZy
 Maa5n4O4vyLiL9fRFPHGpCMvup8L7PfHrkybIj8W5ZpbFlGCjZ5w4UIR4T0ZFF5stbIi Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv51q9403-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Jan 2023 20:28:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302KC3Nj018039
        for <linux-s390@vger.kernel.org>; Mon, 2 Jan 2023 20:28:18 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv51q93yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 20:28:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3029UxeU028079;
        Mon, 2 Jan 2023 20:28:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6a2ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 20:28:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302KSCRb46465496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 20:28:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D509020049;
        Mon,  2 Jan 2023 20:28:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEAAA20040;
        Mon,  2 Jan 2023 20:28:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 20:28:12 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com
Cc:     linux-s390@vger.kernel.org, vneethv@linux.ibm.com
Subject: [PATCH 0/1] docs/ABI: removing those invalid email-addresses
Date:   Mon,  2 Jan 2023 21:28:11 +0100
Message-Id: <20230102202812.3336171-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8n85jqqtzxqLu6TAF3qzj6NQSCCW_Q3E
X-Proofpoint-ORIG-GUID: KT6_vvT6YNzWPasGrej516iWaVUQNKEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_12,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=819 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020181
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Conny,

Happy new year.

Let me do this cleanup before i forget again. As suggested, i have
removed your email-addresses from the sysfs-bus-css file. It make
sense to remove the invalid email-address and keep the linux-s390 list
as the primary contact.

Would you like to retain the redhat-id in the driver-override session ?
I have just deleted that too. Please let me know if you would like to
keep it.

Vineeth

Vineeth Vijayan (1):
  docs/ABI: use linux-s390 list as the main contact

 Documentation/ABI/testing/sysfs-bus-css | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.34.1

