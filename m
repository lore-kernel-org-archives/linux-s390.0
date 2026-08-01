Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060D36492C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582623; cv=none; b=XD7z+M0pNEVyUR+u02dvu9fQX0ByZOYR7ppaQ1BKk2ya5YGvboLlAbBfHCtXLzW3q+3TT4bgTkBJTBLBbHzntmqCyoI6FSD+KiuiNK+53Zi4IQ/rTzPjqEyeBdfqbPWhzMi2XreZSRAkhh4j/fXWT2/7P+04fHTOBFARkkcPpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582623; c=relaxed/simple;
	bh=ZwJfYn8cunuwH9BpPqKvMp9kpCIH/w+oULypc1GBW1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkHYIIYrVD6V+GYEnjHs6Cm9vEn+ZlR7eUwnx23hreumYxjmy1FvI08v+JXQZV8sOS50/ZksEbb/rWkp1s/VvqbQrYG8GzOjs5qg373T0QwWKomZb9s+zs4tq9wpt2MmwXEaVWstRZtMP+67krdCCPvPJqyvDai05XlNvOiy534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N51ut6fZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N51ut6fZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712juj23616795
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=mhn+krqR35zyhpFwrgP6muWxMdT4
	+DjvMIWxnFvJVkY=; b=N51ut6fZyd1L9nfnN2Lbrwt3ULz/LL5b7AHkz2Dp7oRR
	0QLeY1lM3uxWpUd2dgs5LaPG/jCzV9iBNlac4o9pQJLKZIH+d/J+lteVENd6nVDV
	1cwHxx91ejFoAtpJBoN8qt9BgLbUZOs9aBKZlJQtcbflwVrMQnU7u/9aQL25sQ5V
	fsPodrwv0KgqOX87c3t/Ihi2Pfa+uCFH3cDKKlNIuSrRJN8LnKgRGgfPtkxoone+
	Xj1qHQZcq/XpDDkMUI1198KIq/ll77hKsKjKiIWGK4nB0c7LpBX4HVe9a5Nu2/rn
	w7kb2PL0f0xpkgtfiz1Dnc2H7zB0J2pI9+ZC8XdwyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3h4f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuLwL014239
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ykeet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAGWD32702830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 950B820040;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7326720043;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 00/18]  s390/dasd: ESE thin-provisioning performance improvements
Date: Sat,  1 Aug 2026 13:09:50 +0200
Message-ID: <20260801111008.3391031-1-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6dd41d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r5mnGd-IuBsN0NXDk3cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9C4XSUGaZHxqSTkoF-XrkkgDPat_Mnl4
X-Proofpoint-GUID: 9C4XSUGaZHxqSTkoF-XrkkgDPat_Mnl4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXztzIEWUnE+pT
 PPCUgvuHsUu86TVA1yzQPDDa9Gu63VEoUxh9rAiJ1IsTmBxsozVfyEpXIM4d0HPtLnJ5RiBSAIN
 3tsgGc8wUIWyd6fktH/DMVen5LRREcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX59GBE+pphTeX
 60mYWkPw+EX2vjNJ/IwOQnieIMbwJ/+7IyHKrTaqAk2q4NootrTnQYjKXjXZuDgBoAkT7KyxkeI
 CTkDL2OP2G2Y1i1cqmMDMplrcOH5KT3j7gTwaG7fQQzoGkYYAAlBqwEziuQSexXvuA66T2KULnZ
 fqRl+89Hc3ObnxGypTZZUeh0O9NH8/vhuUSxXPItfn4PEyWcQdjYQ4HipSWChrkNXw7AiTBASo8
 hA5rtD/3RQ4qLATbMHG7xXGR1bvBePgJvSXytQasKc5YwEvigEAfKPACOUhT35TuOzpjL1wUjw4
 XVUHKGDt9KvxwfSes9a4XD0i2J52fjl6PKP90EupTwTwd+sJLWkxYCvH2wkd7szXvTmkGgaTS/l
 diNfmVj4neEW8+pGixKRDYObSmAm61fu83kN1twffN3iTxkNEqTY+EJpRS6V9SQTJH2UF4PhmXz
 i008nD3+zGAv63673ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010083

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

Patch 17 releases whole extents only: a discard range is rounded inward to
extent boundaries and partially covered boundary tracks are dropped, so an
extent shared with a live allocation is never released. Sub-extent discards
that cover no whole extent are rejected rather than over-released and
corrupting data.

Patch 18 fixes a use-after-free: the CCW build path read the base address
and LSS directly from conf.ned, which the reload worker can free
concurrently with I/O. The values are now read from the copies kept in the
device uid / private structure, refreshed under the ccwdev lock when the
configuration is (re)read.

Fixes (pre-existing):
  01  Do not complete a failed ESE read as successful
  02  Propagate partial completion length across ERP recovery
  03  Guard sysfs discipline callbacks against unallocated private data

v5->v6:
  - New patch 01 (prepended pre-existing fix): dasd_int_handler() no longer
    completes a failed ESE read as DASD_CQR_SUCCESS. ese_read() can return
    an error before it has zeroed the destination buffer, which would hand
    the block layer stale memory; it now fails the request through the
    normal error path.
  - Patch 03 (sysfs guard): query_host_access() now also guards
    private->lcu, which is NULL in the same set_online window while
    host_access_count is world-readable; the added !private guard alone did
    not cover the private->lcu->pav dereference.
  - Patch 10 (build_cp builder): the newly added
    dasd_eckd_build_cp_tpm_writefulltrack() is marked __maybe_unused
    (removed again in patch 11, where it is first called) so the
    intermediate commits do not emit -Wunused-function / break a
    CONFIG_WERROR build.
  - Patch 11 (WRITE_FULL_TRACK): dasd_generic_requeue_all_requests() now
    skips an aborted (replaced) request instead of requeuing it - the
    request is retired by its full-track replacement, so requeuing it here
    would double-handle the block request. (The shared flush path already
    handled this via __dasd_cleanup_cqr().)
  - Patch 11 (WRITE_FULL_TRACK): the ERP retry request now inherits
    filldata (dasd_3990_erp_add_erp), so an ERP retry of a full-track write
    stays recognised as one and is failed rather than misrouted back into
    ese_format() - which would rebuild a fresh full-track write and could
    loop on a persistent INV_TRACK_FORMAT. ese_format() also fails fast on
    a permanent -EINVAL build error instead of retrying it.
  - Patch 13 (adaptive heuristic): the NRF-rate computation uses a u64
    intermediate so nrf * 1000 cannot overflow int, and the FT0_STABLE
    branches now re-assert fulltrack = 0 so a value left behind by a racing
    sysfs full_track_bias write self-corrects instead of leaving the device
    in full-track mode.
  - Patch 15 (detect ESE from label): the rewritten dasd_eckd_is_ese() now
    guards a NULL device->private, matching its sibling
    dasd_eckd_on_demand_format()
  - Patch 17 (re-enable discard): a discard that covers no whole extent is
    now completed as a benign no-op (BLK_STS_OK) instead of
    BLK_STS_NOTSUPP.
    Discard is advisory, and -EOPNOTSUPP only ever originates from the
    discard builder's "no whole extent to release" paths; returning NOTSUPP
    made filesystems treat the device as lacking discard and stop issuing
    it. The request is ended after the queue lock is dropped.
    dasd_eckd_disc_limits() also guards a zero extent size before the
    modulo, so malformed RDC data cannot divide by zero at bring-up.

v4->v5:
  - The sysfs private-data guard (patch 02) was moved out of the callers
    (the DASD_DEFINE_ATTR() macro and the individual sysfs handlers) into
    each discipline callback that actually dereferences device->private, so
    a caller need not know whether a callee uses private. This also covers
    the callbacks that were still unguarded: is_ese(), the extent-pool /
    space attributes (ext_size(), ext_pool_id(), space_configured(),
    space_allocated(), logical_capacity(), ext_pool_warn_thrshld(),
    ext_pool_cap_at_warnlevel(), ext_pool_oos()), hpf_enabled(),
    reset_path() and query_host_access().
  - Full-track channel-program builder (patch 09): crosses_page() and
    reserve_nocross() now use offset_in_page(); reserve_nocross() fails
    atomically without advancing the fill pointer; datasize simplified to
    trkcount * tlf; plus minor cleanups (declaration order, dead code,
    comments).
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
    functional change); the count_exts() comment was trimmed to just
    describe the formula.

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

Stefan Haberland (18):
  s390/dasd: Do not complete a failed ESE read as successful
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

 drivers/s390/block/dasd.c          |  226 +++--
 drivers/s390/block/dasd_3990_erp.c |    1 +
 drivers/s390/block/dasd_devmap.c   |   87 +-
 drivers/s390/block/dasd_eckd.c     | 1258 +++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h     |   68 +-
 drivers/s390/block/dasd_erp.c      |   11 +-
 drivers/s390/block/dasd_int.h      |  149 +++-
 7 files changed, 1604 insertions(+), 196 deletions(-)

-- 
2.53.0

