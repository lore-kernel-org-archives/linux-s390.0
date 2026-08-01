Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0163BB124
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607244; cv=none; b=mvMW34sUNKzaHq0MXatSFr9SdxxdPVgaRCmr95wUjU2Y0GNuV0vT+3g83nTuxk7tkaij44ULTKkWwNnod3ML0KSD7IOXtus0bFvRIJwDstianeRiymD0nDpte78wgGpkb69vd4d5i4/tWuGjDtyNt75KOGreAvTL71I6CYPeweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607244; c=relaxed/simple;
	bh=XMKwz0k+njYMlqP5ElUWXMPrp+hW9w9w/Upc0QoF8dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILDOQxTqJYjY0alSN7MaFiv5htafK0HH3190ER8S9dRsIzCj9FEJrRhVgDriNpKjO26qIJJGuhoGreoIJSP+Q+jB0PD3SgH/womKSwZpy7ky4UtIyYeGWyFjxMePuCR5VI0dwxeRJNS2lDevLvzBYKrmJwjDXf1exQLgO9NkxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1j+58iC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1j+58iC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Fo2Ks964668
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=uOGnAr2xB+x0wSOa290NeWRgkRMN
	BloKyXDeVlxlBxM=; b=B1j+58iCwGKVHgFnZc/abD02sgkM7V51/nZJwxluGODt
	8dxB2pcXt0ppSkEKcUC3FO6mdKFz+EozoCFtm5Lid0+EtkIi8JKl3R6J8VMb/vH9
	+33APcWM92c7+6F+/N/eGP20weoSa1BVOQyxshSe+UfluBYofDfUaC6hGcl48mmR
	BJrVEQZ+7bucZxCqyEIy4gg9Ti0th72uSe5Tqoifn/Z0yiaqhwQbdvbbCJCcVSPf
	ipG2dw0Nu1GM8RCGrvr2qljxyzyAjlktQlx9GxTpgt2uSiV4IDJkR0em/lrcfbRv
	gchYyjHqyYxlH5RRwRCjPgwf0DdD1tFSXe2TtUZ32A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4j26y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuIvl014474
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkmr96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0a7245875556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C6E22004B;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C39720040;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:35 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 00/19]  s390/dasd: ESE thin-provisioning performance improvements
Date: Sat,  1 Aug 2026 20:00:14 +0200
Message-ID: <20260801180033.3679412-1-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX1fM6obf8mFso
 8n0acCcGS4HU9PcJHejSQxLr88Xuw7Jjw43QGOWOGZWsv+fGYgWcO6GJiHJOuk3AgatDtQ6IzeO
 ktYXRPa8RwxYYxYn/jD6a30QoeEFJe0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX/AnNNZY974Cx
 KZtArC8jLYgR/uEomqgmIZjGMb9K4km50lWvGxRTB8QIzdh5bMFWcqFkbvAKE2/6mwL51qCkWu3
 uifb7mOrPRqL+35S8++voyusQu1z6TcLsnnsvlZHR7NZKVxaOWCj+paJ04SE/sBC8g4AZoIXCKn
 oMgEp8LQjVyFivHTmMelfU4JVZ8nvcGkb2hrLszU+pUSN5MifOi/ygaQgaIsE1h2np+F+LzqyDV
 a9bExraQhTrai/zbqglUmnKwaDjgn91YtlFswIaENRRE6CWplPMQIuoKgW0Gz8Zvg7aU8KJOHv7
 WADxH6YX7NIlrys/z/glCS1hlqHpu0B51Ri4cli//2Q0VNC6lnNmDAuAIwfm1V00gimEeDzg7tU
 /LRWl8e5h5hHt9MrGOMyL63xsf6QFmAta5P8vMRLyMvnJu28MqpUSxDqhKsQf1OF41407AaXFFK
 i1Xlr6+8o359pr1mTZQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pO5zmtwNW9dwNxBYuRMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t1yzN-IcwWsZp5N1Nr1EJSlJO_B3b8xe
X-Proofpoint-GUID: t1yzN-IcwWsZp5N1Nr1EJSlJO_B3b8xe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010143

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
  02 Propagate partial completion length across ERP recovery
  03  Guard sysfs discipline callbacks against unallocated private data
  04  Snapshot intrc before freeing the request block

v5->v7:
  - New patch 01 (prepended pre-existing fix): dasd_int_handler() no longer
    completes a failed ESE read as DASD_CQR_SUCCESS.
  - Patch 03 (sysfs guard): query_host_access() now also guards
    private->lcu
  - New patch 04: __dasd_cleanup_cqr() snapshots cqr->intrc before
    discipline->free_cp() returns the request block to its memory pool
  - Patch 08 (infrastructure): added a comment on the DASD_CQR_ABORT case
    explaining that clearing cqr->callback is safe: ABORT is only set on
    the block-layer origin write that a full-track format replaces, never
    on an internal request, so no dasd_sleep_on() waiter is left without
    its wakeup.
  - Patch 09 (collision detection): the two intentionally lockless fields
    are now accessed with WRITE_ONCE()/READ_ONCE()
    Both are functionally benign; the annotations document the access and
    silence KCSAN.
  - Patch 11 (build_cp builder): the newly added
    dasd_eckd_build_cp_tpm_writefulltrack() is marked __maybe_unused
    (removed again in patch 12, where it is first called) so the
    intermediate commits do not emit -Wunused-function or break a
    CONFIG_WERROR build
  - Patch 12 (WRITE_FULL_TRACK): dasd_generic_requeue_all_requests() now
    skips an aborted (replaced) request instead of requeuing it.
    The request is retired by its full-track replacement, so requeuing it
    here would double-handle the block request.
    (The shared flush path already handled this via __dasd_cleanup_cqr())
  - Patch 12 (WRITE_FULL_TRACK): the ERP retry request now inherits
    filldata (dasd_3990_erp_add_erp), so an ERP retry of a full-track write
    stays recognised as one and is failed rather than misrouted back into
    ese_format()
  - Patch 14 (adaptive heuristic): the NRF-rate computation uses a u64
    intermediate so nrf * 1000 cannot overflow int, and the FT0_STABLE
    branches now re-assert fulltrack = 0 so a value left behind by a racing
    sysfs full_track_bias write self-corrects.
    dasd_ft_bias_apply() is now called after dasd_eckd_read_vol_info(),
    not before it    
  - Patch 16 (detect ESE from label): the rewritten dasd_eckd_is_ese() now
    guards a NULL device->private
  - Patch 18 (re-enable discard): a discard that covers no whole extent is
    now completed as a benign no-op (BLK_STS_OK) instead of
    BLK_STS_NOTSUPP.
    Returning NOTSUPP made filesystems treat the device as lacking discard
    and stop issuing it. The request is ended after the queue lock is
    dropped.
  - Patch 19 (cached unit address/LSS): the ned_ua and ned_lss caches,
    written under the ccwdev lock in dasd_eckd_generate_uid() and read
    locklessly in the CCW-build path, now use WRITE_ONCE()/READ_ONCE() to
    document the intended lockless access and silence KCSAN.

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

v2->v3:
  - use GFP_KERNEL for allocations in dasd_alloc_device()
  - Renamed the fulltrack aggressiveness knob: the per-device sysfs
    attribute ese_aggr is now full_track_bias (internally abbreviated
    ft_bias); the associated constants and the apply helper were renamed
    to match.
  - Added a full_track_bias module parameter (0..100, default 50) that sets
    the initial value applied to every device at online time; individual
    volumes can still be re-tuned through the sysfs attribute afterwards.
  - The on_demand_formatting sysfs attribute now reports the actual format
    mode of the volume (formatted on demand / quick), read from the on-disk
    label, rather than the ESE capability of the hardware that the separate
    ese attribute already reports. A fully formatted ESE volume therefore
    reports ese=1 but on_demand_formatting=0; volumes without a label fall
    back to the ESE state. This keeps the device property (ese) and the
    driver behaviour (on_demand_formatting) cleanly separated.
  - New patch 11 "Report ESE capability and format mode at device online":
    the device information line logged when a volume comes online now also
    reports the ESE capability and the format mode (full / on demand).

v1->v2:
Patch 2/12 - "s390/dasd: Add infrastructure for ESE full-track write"
  - add missing cleanup of staging queue
Patch 6/12 - "s390/dasd: Use WRITE_FULL_TRACK in ESE format handler"
  - remove unused variable
  - fail the cqr on a dasd_eckd_track_from_irb() sense-parse failure
  - call dasd_device_clear_timer()/dasd_schedule_device_bh() in
  dasd_int_handler for failed CQR
Patch 10/12 - "s390/dasd: Detect ESE volumes from the on-disk format label"
  - move the dasd_ese_apply_aggr call in dasd_eckd_check_characteristics
  after dasd_eckd_read_vol_info()/dasd_eckd_read_format_label()
  - populate private->ese_label directly in dasd_eckd_fill_format_label
  - add on_demand_formatting sysfs attribute to show difference between
  internal handling vs device feature (ese attribute)

Stefan Haberland (19):
  s390/dasd: Do not complete a failed ESE read as successful
  s390/dasd: Propagate partial completion length across ERP recovery
  s390/dasd: Guard sysfs discipline callbacks against unallocated
    private data
  s390/dasd: Snapshot intrc before freeing the request block
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

 drivers/s390/block/dasd.c          |  243 ++++--
 drivers/s390/block/dasd_3990_erp.c |    1 +
 drivers/s390/block/dasd_devmap.c   |   87 +-
 drivers/s390/block/dasd_eckd.c     | 1258 +++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h     |   68 +-
 drivers/s390/block/dasd_erp.c      |   11 +-
 drivers/s390/block/dasd_int.h      |  149 +++-
 7 files changed, 1620 insertions(+), 197 deletions(-)

-- 
2.53.0

