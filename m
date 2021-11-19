Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A1C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D357161221
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 10:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhKSKvE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:51:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229843AbhKSKvE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 05:51:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAgkqa002432;
        Fri, 19 Nov 2021 10:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wUcXGEWGnF+3/I7AmpsR+d/nS7Ul250ciiKvgphWc2o=;
 b=JjRyxc/ONtULxEPuYc0q4Jqe3dyqSew0HqgDJk/TJMxUlsvCSe6pAOTv7pnR/McF4LSm
 TCE5OKQzFM5jxsWQiYT1882oFTBhnEv8S8XSjJlDFSDbqUI2pf18fkvMG7qRpSCDrsV4
 C0H4ZTQ+Hi3m2PHeprQbTD+KznWDZLyTUaAyV8CIgRYWI/h7NiI9V9mbM+vK95pRmfzW
 CeAF3wjgsrA9dUdBBJcp6A2ovOLWKnDbv7z+JJqHU9czYb5u+RcVfEp2aS5oWM0jmuKx
 yXgaKdp0jixYBdQm/NkHHQbNrNB0d/fXco6yELk7AVOQt9PsW5pPdY3G15dmR+wrsRWx oQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ceadp834d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:47:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJAldRv029958;
        Fri, 19 Nov 2021 10:47:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca50ayk7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 10:47:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJAlrnI63045924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 10:47:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B39BC42041;
        Fri, 19 Nov 2021 10:47:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47CA84203F;
        Fri, 19 Nov 2021 10:47:53 +0000 (GMT)
Received: from sig-9-145-57-93.uk.ibm.com (unknown [9.145.57.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 10:47:53 +0000 (GMT)
Message-ID: <a627b3cbd2ed4ba5dd75e1163760730187f1416b.camel@linux.ibm.com>
Subject: Regression in v5.16-rc1: Timeout in mlx5_health_wait_pci_up() may
 try to wait 245 million years
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Amir Tzin <amirtz@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     linux-netdev <linux-netdev@vger.kernel.org>,
        regressions@lists.linux.dev,
        linux-s390 <linux-s390@vger.kernel.org>
Date:   Fri, 19 Nov 2021 11:47:52 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9_a_1aVXWXsCgcALaPjQh5LCLifi7IUm
X-Proofpoint-ORIG-GUID: 9_a_1aVXWXsCgcALaPjQh5LCLifi7IUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_08,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Amir, Moshe, and Saeed,

During testing of PCI device recovery, I found a problem in the mlx5
recovery support introduced in v5.16-rc1 by commit 32def4120e48
("net/mlx5: Read timeout values from DTOR"). It follows my analysis of
the problem.

When the device is in an error state, at least on s390 but I believe
also on other systems, it is isolated and all PCI MMIO reads return
0xff. This is detected by your driver and it will immediately attempt
to recovery the device with a mlx5_core driver specific recovery
mechanism. Since at this point no reset has been done that would take
the device out of isolation this will of course fail as it can't
communicate with the device. Under normal circumstances this reset
would happen later during the new recovery flow introduced in
4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery") once
firmware has done their side of the recovery allowing that to succeed
once the driver specific recovery has failed.

With v5.16-rc1 however the driver specific recovery gets stuck holding
locks which will block our recovery. Without our recovery mechanism
this can also be seen by "echo 1 > /sys/bus/pci/devices/<dev>/remove"
which hangs on the device lock forever.

Digging into this I tracked the problem down to
mlx5_health_wait_pci_up() hangig. I added a debug print to it and it
turns out that with the device isolated mlx5_tout_ms(dev, FW_RESET)
returns 774039849367420401 (0x6B...6B) milliseconds and we try to wait
245 million years. After reverting that commit things work again,
though of course the driver specific recovery flow will still fail
before ours can kick in and finally succeed.

Thanks,
Niklas Schnelle

#regzbot introduced: 32def4120e48


