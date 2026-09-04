Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67494E8E08;
	Fri,  4 Sep 2026 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561343; cv=none; b=meL0tEE7LYCMN07Sjh46Ti9QWk+hPlRaDyi6q92yiGgVnIyCcrpHNAnPIgNNpNJbFpnpShUtnYRuc63+hluab/McnzK+q6iXGeXlX1403GCpxYwahSoJdgcO5yYUa2BJ0Aux2hxzEMxEw48D7QvGs9wBAVG+sIuPJIIOm+myjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561343; c=relaxed/simple;
	bh=1WHYw5fGJr1WmcN1NHRNZZEGmrXEGCksucSJyKzBMqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tVivsybW6gmp7ToDImiF9bXORbmmiMw/T+m9UbZwidqx3qsraMszo4vc+nCVknzMGAagxmrJJfqkcl/i0HClvQ1h/QJe3WZZKcpG7MlwyQiQTP4siedNztC115+D+7DlLR6/IHL3JaeJQZCRwtKVGllyFhakWiiaL6/3cjaJzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g8rHID+l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g8rHID+l"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684L1fXR939220;
	Fri, 4 Sep 2026 22:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/klnx6YMBQpIpE7BvIXtP/6jTEcl
	eQ/oSzLymvi+VM0=; b=g8rHID+l3ZnZTj1xwB1nZ6+7U+TPNjCnY+lebj2X25qP
	I7I2r5Fjj2JJBjveMp+d1LNl7bKOYaKad+kBgk6CtxNdU6YJDw7Rf38yfxiPkz27
	2/3+cATIPAB9yn5cPNOowWIeyPcyqlL79aoKoUe6ys5BlEOZoK+ufqc0mDOPmNA8
	fjjbzoDHdbpgILGhnmLYo+Cp0B+CsEz5KUk49Ardqf10q+wrS6WCy/zNboyVRdT1
	swd2U+eM08z25b8Q5h3frNO1sIqylEy4tVC1c+Bed8EGCKk6MPr76lMKoepH3LcK
	T9bcd0MSHO+TV6K2imQgDL4Yn3Pn6ed+nQmUu4AvqQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rwkpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684MQOAB011777;
	Fri, 4 Sep 2026 22:35:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjb009j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 22:35:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684MZXSv1377188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 22:35:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A9658065;
	Fri,  4 Sep 2026 22:35:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E211F58056;
	Fri,  4 Sep 2026 22:35:31 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 22:35:31 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 0/6] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Fri,  4 Sep 2026 18:35:25 -0400
Message-ID: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9b47b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=PgqzwkaAYJtpdSb6i4cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfXwK0yc7cfiBH7
 /HimqhcCdg3qQ51kxfTUt2AbHxlg1WA3fRnCbcycWksWzi2FLAIf4y04lEl6fw/qgVex690FQCY
 cfNsuOqCnnBhcONeNRuhcHX/CVIz60DmVps6RxfsbKjU6Uw07XSSUdBNITlkGgZXHqL17xdthp2
 V2IZgWIW3B4lenCSkaesAM7EZYM0xC13cCPnTMCSMXL13wi3mXx4VakaxLIBkbQkpmxUcufkvfs
 uQ4rz4j7K7F8bGUiC2Ii8zX0UGe09WHsBSO4CKrl1rW2FsxwO+WgSak3lLd6LO6+zY0LHYhKi/S
 ziqdJQkQF3lA98Dvns+ghMqH1tgFU0W3iQV+BPGoHfiZBf2bAQ7c76v/f4y6dyRxcguai4TRQTH
 cE8PR6NcHFX8kO1hbdh935z6IDnQLcNkSFXKBW/FeR0kqgxujGDsCl0wJ9602n5r81dxDWtVqLN
 BrMzPDEr/sOd5eZSkSA==
X-Proofpoint-GUID: LKdd79r618bygc0k-CLaP89X4Pd-vciH
X-Proofpoint-ORIG-GUID: LKdd79r618bygc0k-CLaP89X4Pd-vciH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX265A4gdb4MLa
 +9cPrcWz8/9GkF63dMkDFIuZjn3TImk/Ri+QF/DxIOpwjOfHClsyPkkKZDwu37Vm7w9Tpn2wWp4
 P937BF1N3d6x6rjL0wUvEdzq+CsJsNw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040209

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Change log v6 => v7:
~~~~~~~~~~~~~~~~~~~
Patch: s390/vfio-ap: fix queue state leakage to guest and host

  apq_reset_check()
  - Fixed missing closing brace on -EIO early-return block that
    made the AP_RESET_MAX_WAIT timeout check unreachable.
  - Introduced apq_reset_finalize() helper to copy the final
    TAPQ status word to q->reset_status and set
    q->reset_status.response_code to AP_RESPONSE_NORMAL only
    when zeroization is confirmed (ret == 0). Replaces the
    done: label and goto.
  - Both pre-timeout and within-timeout completion paths now
    call apq_reset_finalize() directly.

  apq_status_check()
  - Signature changed from (int apqn, ...) to
    (struct vfio_ap_queue *q, ...) to support ratelimited
    warning reporting.

  vfio_ap_mdev_remove_queue()
  - Removed post-lock fallback unbounded reset block that had
    a use-after-free risk on q->matrix_mdev after
    release_update_locks_for_mdev().

Patch: s390/vfio-ap: replace guest-reachable WARNs with
       ratelimited warnings and add dmesg visibility to DBF_WARNs
       
This is a new patch created in response to review comments of the
v6 series.

  vfio_ap_wait_for_irqclear()
  - Signature changed from (int apqn) to
    (struct vfio_ap_queue *q).
  - Replaced WARN_ONCE calls with report_tapq_rc() and
    report_irqclear_timeout().

  vfio_ap_irq_disable()
  - Replaced three WARN_ONCE calls with
    report_aqic_disable_error().
  - Added AP_RESPONSE_STATE_CHANGE_IN_PROGRESS to retry case.
  - Added AP_RESPONSE_INVALID_GISA,
    AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE and
    AP_RESPONSE_ASSOC_FAILED as explicit end_fail cases.

  vfio_ap_irq_enable()
  - Added dev_warn_ratelimited() alongside each
    VFIO_AP_DBF_WARN() call for dmesg visibility.

  handle_pqap()
  - Added pr_warn_ratelimited() for AIV facility not installed
    and hook not registered cases.
  - Added dev_warn_ratelimited() for mdev not in use and queue
    not bound cases.

  apq_status_check()
  - Replaced WARN with report_tapq_rc().

  vfio_ap_mdev_reset_queue()
  - Replaced WARN with report_zapq_rc().
  - Removed AP_RESPONSE_BUSY from async-reset case (not a
    valid ZAPQ response code).

  New functions introduced:
  - apq_reset_finalize()
  - report_tapq_rc()
  - report_irqclear_timeout()
  - report_aqic_disable_error()
  - report_zapq_rc()
  
Anthony Krowiak (6):
  s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()
  s390/vfio-ap: fix queue state leakage to guest and host
  s390/vfio-ap: replace guest-reachable WARNs with ratelimited          
        warnings and add dmesg visibility to DBF_WARNs

 drivers/s390/crypto/vfio_ap_ops.c | 539 ++++++++++++++++++++++++------
 1 file changed, 441 insertions(+), 98 deletions(-)

-- 
2.53.0

