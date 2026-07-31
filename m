Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1C31714B
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512350; cv=none; b=CyzNee3QyfX90yXREZ6dBtnmnPBLaZCUahfL07K17EO2gLUD+bVFzorBEFy3yv21bmzl01idKu9tQUAMpUVkeSRoc8wjZ2ocuN5bgPykxpbaNxs4BWOl2hqfcqodus3EjvxQLT0/Htx1ArolYUsavarosFRXJMB9Ejlyb/WIqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512350; c=relaxed/simple;
	bh=h4/Ao1b7YL1ozZJ2waXOd2DQ0xgkUT1ACIc1hSiFFcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyIhKrDp+xm7Y4NW3xPEpzE4Yf/9UPImDqwlHgyg4V9Oehc5kTwH0cI3f8NqegnddwOgroFbLk5XQWFPWZGATG8u+tEVfq8HOjv2l7ckmvv0eW2mSgsj9jEChvsf+/i/h390nS/H/Wi4VHwNpkz3zphz5K8ku4pnHL7envNds7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Egg8meqL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Egg8meqL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm3kA1766156
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=nf/ZUc01HFL7vzi4LvWp8+EXjSOS
	/b2ibH4o9nURIe0=; b=Egg8meqLHp+tnSPusBFktKsTLIj+QA+YCh2Oj/yq+5yH
	3sunJ9nVp9NfhJw7tC4L085KF3YV9qH/CNgf8/GydbH3cD3zsNhL2k+g7ziLGYPJ
	h3+oXjwEbwJknvD7tEMO4wI6TFvCjLaiySQkrlYtGoYn3eHSdDWxXnYgCiVsK+Sn
	r8KzDe5jWZ1cLvzLBUBCliaH2NLAUQB6GS+/71zpEeb7pu7Q2+zrEaKtVxl8JRgs
	Mlg+pBmp8evCXhpKHkP0t5VICKHU0mLqzGE2psjN8tztdfOgSgMaD/Qee8sma3hF
	HuYY6du46StxwdpOWxAdPbO5VEZbcY2ij/tJR7GYtA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y5u6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQcn3009355
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yg7rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFcxZa30474566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:38:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C3520049;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DFD520040;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 00/17] s390/dasd: ESE thin-provisioning performance improvements
Date: Fri, 31 Jul 2026 17:38:25 +0200
Message-ID: <20260731153842.1729627-1-sth@linux.ibm.com>
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
X-Proofpoint-GUID: viS1_Bfjf2uYqwVCKe1LN5iKmJvlBXgz
X-Proofpoint-ORIG-GUID: viS1_Bfjf2uYqwVCKe1LN5iKmJvlBXgz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXwtrmqolF4OkU
 zpxn5gf4mtlc+mqZJa6Kco9Xyak1ix+xnY9HpZAhiTM5mYoDmtz8UNMtI/GyQ/fgfv6tDZm6pfr
 4wkIqgGVFJx81TS9f96z4JA9FcugzXI=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6cc198 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mQQfiyfnuR3Ntl573RQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXxbqyVqVCmYpZ
 Q79It7lI1HKKBKAPe3QgbEu6VHQ8JojvRTzuCfbrRa4NVOTYb06x5yJ9ZJl2CKd7s3hsdrcuWXA
 ibUxo63y62vmN/8M8Q4Cv7R/TbgoMdeOZXts3WMvN1Evk2i4VNNpUNBsaTIw1ByAiYIhOGWKD7Z
 s0+vWLKpAatPgv86+LUxu+mKIdgXme176MU3z9ua2AI70u9Ml4JxaKLf6wb78T/FSk5kY6JH72f
 gxS4I3/RTT1tQOKnt4CLlXqhTMddME58tmJ8NjbBWb7BbjxlryOP8sx2aSAuK9C6nlmzpeZ32nX
 CPIx19wv81B+D3UfGrd8xELJm6P7syX+3tco+52U/wbhfOV84YD0J31wPelWAqe5cSDoeJulJeH
 7vWTdNd0kouRHsCK72hMg8eBMs/ov6K6L6KMpnGPem1bej9qpjq3FXkYAJ2jUURR7s9YvnC35YV
 ALD0ovi876sAi3lRqfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

Extent Space Efficient (ESE) volumes allocate a track on its first write.
Today the first write to an unallocated track fails with No Record Found
(or similar), the driver formats the track and retries the write.
That NRF loop dominates the write path of a freshly provisioned volume.

This series lets the driver write and allocate a track in a single
operation using WRITE_FULL_TRACK, so the common "write to a
not-yet-allocated track" case avoids the NRF penalty.
Because full-track writes are only a win while a volume is still sparse, an
adaptive heuristic (exposed through a single sysfs knob) probes
the workload and falls back to normal writes once the device is mostly
allocated. On top of that the series adds an on-disk format label so an
ESE volume can be recognised without querying the hardware, and re-enables
discard for ESE volumes so freed space can be returned to the pool.

The sysfs knob is 0..100. 0 pins normal writes, 100 pins full-track,
and the default of 50 enables the heuristic; the adaptive range
interpolates the heuristic parameters between the two ends.

Patch 16 releases whole extents only: a discard range is rounded inward to
extent boundaries and partially covered boundary tracks are dropped, so an
extent shared with a live allocation is never released. Sub-extent discards
that cover no whole extent are rejected rather than over-released and
corrupting data.

Patch 17 fixes a use-after-free: the CCW build path read the base address
and LSS directly from conf.ned, which the reload worker can free
concurrently with I/O. The values are now read from the copies kept in the
device uid / private structure, refreshed under the ccwdev lock when the
configuration is (re)read.

Fixes (pre-existing):
  01  Propagate partial completion length across ERP recovery
  02  Guard sysfs discipline callbacks against unallocated private data

v4->v5:
  - The sysfs private-data guard (patch 02) was moved out of the callers
    (the DASD_DEFINE_ATTR() macro and the individual sysfs handlers) into
    each discipline callback that actually dereferences device->private
  - Full-track channel-program builder (patch 09): crosses_page() and
    reserve_nocross() now use offset_in_page(); reserve_nocross() fails
    atomically without advancing the fill pointer; datasize simplified to
    trkcount * tlf; plus minor cleanups
  - full_track_bias_store() (patch 12) received the same guard-in-callee
    treatment: the offline check was removed from the store, and
    dasd_ese_adaptive() now verifies device->discipline before invoking the
    is_ese callback. The heuristic interpolation endpoints d50/d100 were
    renamed v50/v100 for clarity.
  - On-disk format label (patch 13): the informational per-format string
    now records the running kernel version (uname -r) instead of a fixed
    driver name; the field was renamed kernel_version and enlarged to
    64 bytes.
  - Discard (patch 16): build_cp_discard() now uses roundup()/rounddown()
    with a named inclusive last track for the extent-alignment (no
    functional change)

v3->v4:
  - Two pre-existing bugs surfaced during review are prepended as fixes:
      - ERP recovery now carries proc_bytes back to the original request,
        so a partially completed ESE read that is recovered through the ERP
	chain no longer completes the whole request and returns zeroed data
	for the unread remainder (patch 01).
      - the ese / on_demand_formatting sysfs attributes now check
        device->private before dereferencing it, closing an unprivileged
	NULL-pointer read during the set_online window (patch 02).
  - The dasd_alloc_device() GFP_ATOMIC->GFP_KERNEL conversion was split out
    of the ESE infrastructure patch into its own patch (04): it runs in
    process context and is an independent change.
  - New patch (05) names the Extended Address Volume track-address shifts
    used by set_ch_t()/set_chr_t() instead of open-coding the constants.
  - Full-track write path: the ESE format handler's error, partial
    completion and abort exits now cancel the device timer and schedule the
    bottom halves (a failed request previously waited for the timeout); the
    exits were consolidated behind shared out:/out_retry: labels. free_cp()
    now releases the bounce buffers of an aborted (format-replaced) write
    instead of leaking them. build_cp_tpm_writefulltrack() budgets
    page-boundary padding in the fill buffer, and its in-loop track-end
    length matches the physical track.
  - Adaptive mode selection: full_track_bias no longer enables full-track
    writes on non-ESE volumes by default (only an explicit ft_bias=100
    forces it); the sysfs store rejects an offline device, and the
    heuristic re-asserts the endpoint mode per I/O so a racing sysfs write
    cannot wedge it.
  - On-disk format label: a failed full format invalidates the cached label
    so is_ese() falls back to the hardware field, and the fulltrack
    heuristic is (re)applied after the format commits rather than before.
  - Discard: discard is no longer advertised for raw-track-access (USERAW)
    volumes, which would otherwise route a discard into the raw CCW
    builder.
  - conf.ned fix: the cached unit address is kept in a dedicated field, so
    the lockless CCW-build readers cannot observe the transient zero while
    create_uid() repopulates the uid.


Stefan Haberland (17):
  s390/dasd: Propagate partial completion length across ERP recovery
  s390/dasd: Guard sysfs discipline callbacks against unallocated
    private data
  s390/dasd: Optimize max blocks per request for track alignment
  s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
  s390/dasd: Add defines for the Extended Address Volume track address
  s390/dasd: Add infrastructure for ESE full-track write
  s390/dasd: Add range-based format-track collision detection
  s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
  s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
  s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
  s390/dasd: Add full_track_bias to control fulltrack write mode
  s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
  s390/dasd: Stamp a format label into newly formatted volumes
  s390/dasd: Detect ESE volumes from the on-disk format label
  s390/dasd: Report ESE capability and format mode at device online
  s390/dasd: Re-enable discard support for ESE volumes
  s390/dasd: Read cached unit address and LSS in the CCW build path

 drivers/s390/block/dasd.c        |  201 +++--
 drivers/s390/block/dasd_devmap.c |   87 ++-
 drivers/s390/block/dasd_eckd.c   | 1241 ++++++++++++++++++++++++++----
 drivers/s390/block/dasd_eckd.h   |   68 +-
 drivers/s390/block/dasd_erp.c    |   11 +-
 drivers/s390/block/dasd_int.h    |  149 +++-
 6 files changed, 1564 insertions(+), 193 deletions(-)

-- 
2.53.0

