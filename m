Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E63E1200;
	Mon, 24 Aug 2026 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552051; cv=none; b=PWCqyzrx/nAqNp8LZDVuDDQCNK/WTDPof6257yJnrbyPH1KQ/0JuVInZZoH8vt002t2h3CcQ5R0Y9aNrUFzLBZLnzcjZkQuotNggrQBEjbQS+X9uoALLtlu3Fi23EsUYCVJkl2ZcJEodeGgX4QJMvL8sxOkGsCGR6GObXTCtB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552051; c=relaxed/simple;
	bh=BZ7IwJMO4MfhnQONjq+NB28trzI968B5/QEAjYm1OxY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BuO7fnehmmBOU45UdXvwHuzw2S5nmeSQkk9T+hZZqty0g3bSTAQ6Iy9CGUAR0CHAC2QcBdU3toZ+zz65+d+ApPHpY0GMGfENDXLApthppkrwh3AbdMC6QJouofSjLwAh2N8iWBtS8MiWI5P47vq2HyUZS10CEJOgHzHoGpzKMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHDCc/S4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHDCc/S4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VpxJ857153;
	Mon, 24 Aug 2026 06:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ohqzTW2XLqIuG25AhuPv0Xcp52Z9
	X5GJJ42qTZOubcw=; b=aHDCc/S4uzaFaI7J4JmhPFeCofYeklyj/50FUPb+Fjg9
	OjlihNHIBezNqvMaATxfYXBBdy3Z8ONe9I7mFt8FsF9oqfP2I9Q5ILl1umvQmc07
	yN9SvWSNiUpwjRehpUTCm8CHt0DejdGK3oKFoEopChiLIZYrnxsN8y+Y67qBMyHm
	eyLZWSav48LS80p9+EG9pwskSl+ONvP/KxPxvN9oaCjMKtfsdkgOgTd1CeHKGzF/
	c8unIpF/m9/z/XrohuFjakdZsVfHp1NEBQPnbWDQj9QGhN1P3WYtfZCzN9e0UZyg
	TQNgrSDOt6WEqavn8nJIrqeBzgIhxAcRTxYORGpw6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hfr2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 06:13:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O6BGkk013960;
	Mon, 24 Aug 2026 06:13:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgv81p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 06:13:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O6Ds6O9503310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 06:13:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 755EC58043;
	Mon, 24 Aug 2026 06:13:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4575A58059;
	Mon, 24 Aug 2026 06:13:48 +0000 (GMT)
Received: from [9.124.213.220] (unknown [9.124.213.220])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 06:13:47 +0000 (GMT)
Message-ID: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
Date: Mon, 24 Aug 2026 11:43:46 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [RFC] module: init-failure path can free a module with live
 try_module_get() users
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Daniel Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX8iz10sYdxjfN
 ucR+7s4gyC2sWvQR2rG/6q/HOC7re2RiwHzSBUzN0jX/M1ptH1J7DQTVE2LiDFc23ih9blkiOFi
 NneS/AcTYZXycK518rSAMGQhoJj+eXI=
X-Proofpoint-GUID: tyarUeiplgB3t8PjeCrkG0mPQopA7BRG
X-Proofpoint-ORIG-GUID: 4qlPXTpx764y-loKHhdmkaj7ID_i2eIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX97ikndDvwT3Y
 yEbKJdfYYtaZ7CeZINStTKwf6iLzQdTwp+eL2Ai1QZKCgM9Ge8OEAdGDH9peuEKO7Biqv15Gubi
 Cz2Q85Moso+UKx+j+DfVb7TG03upQqN6r6Amv1wu5p0OBokDrRfBT3wydPhdLnsugqKegSuD3Qg
 2nqpTAPpLACI8Tk7IbQAR0H9/WSFEaUhtx9nEq4VQlkLCVey6i0xFHhEtKgQG6fisdTl8YlZ2nf
 iRfTqWrXbRagNBexB11MHS/QZ3qlCJW2vWlU6I0EvgeB3u8v60lytnhAy5/DCPrhKyPjUPuj+mk
 9lC37X90YLY9MPa/Xm0J/XWJHmAqkr7Z07JtBEByLMvrFxTsIcyYBgLSagQIawGtfkYWQUEuZ4l
 Sayj7ei6NysDLXGDwvkjuhx8c6lm3Xtesmg0VXzVtUa3qJJXHRzPXhwNqb+sH+W3Eof1RizLI19
 f3cab1OGOt88zaqFtzQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8be125 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ivB86U3Dv6JuGY3LHcgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240051

Hi Luis, Petr, Daniel, Sami, Aaron,

I'm writing to ask about what looks like a generic module-init failure
lifetime problem in the module loader. I ran into it while working on
the SMC networking module (net/smc/), but after several patch
iterations, it seems the root issue may belong in kernel/module/main.c
rather than in SMC itself. I'd appreciate your guidance on whether this
reading is correct, and if so, what fix direction would be preferred.

THE ISSUE IN do_init_module()
=============================

include/linux/module.h has a long-standing FIXME in module_is_live():

    /* FIXME: It'd be nice to isolate modules during init, too, so they
       aren't used before they (may) fail. But presently too much code
       (IDE & SCSI) require entry into the module during init. */
    static inline bool module_is_live(struct module *mod)
    {
        return mod->state != MODULE_STATE_GOING;
    }

Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
can succeed once a module's __init is executing. If __init makes the
module externally reachable partway through and then later fails, the
failure path in do_init_module() appears to do:

    fail:
        mod->state = MODULE_STATE_GOING;
        synchronize_rcu();
        module_put(mod);
        ...
        free_module(mod);

synchronize_rcu() waits for RCU readers, but not for threads that
already obtained a module reference via try_module_get() and are still
executing module text.

By contrast, the normal unload path in try_stop_module() refuses to
proceed while the refcount is non-zero.

So the asymmetry seems to be that the normal unload path waits for
references to drain, while the init-failure path does not.

A concrete race would look like:

  1. Module __init registers an externally reachable interface.
  2. User space enters through that interface and try_module_get()
     succeeds while the module is still COMING.
  3. A later __init step fails.
  4. do_init_module() frees the module.
  5. The in-flight caller is still executing module text.

SMC AS A CONCRETE EXAMPLE
=========================

In SMC, simply moving registration later does not appear to eliminate
the window, because there are two separate registration points that can
make the module reachable via socket():

  1. sock_register(&smc_sock_family_ops)
     After this, socket(AF_SMC, ...) can succeed and reach
     try_module_get() via __sock_create().

  2. smc_inet_init() -> inet_register_protosw()
     After this, socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) can succeed
     and again reach try_module_get().

Either registration point can succeed before a later init step fails.

This may not be specific to SMC; other protocol modules that become
reachable during init, such as Bluetooth, may have similar exposure and
appear worth auditing as well.

ON THE FIXME'S IDE/SCSI CONCERN
===============================

The FIXME mentions IDE and SCSI as reasons not to isolate modules
during init.

  1. IDE was removed in Linux 5.14, so that half of the concern no
     longer applies.

  2. SCSI still appears to self-reference during init
     (scsi_device_get() -> try_module_get(hostt->module) during
     scsi_scan_host()), so a blanket wait-for-refcount-to-drain
     approach in the failure path may deadlock there.

Also, strong_try_module_get() already rejects MODULE_STATE_COMING with
-EBUSY, so the infrastructure for refusing callers during init already
exists in some form.

QUESTIONS
=========

First, is my reading of this init-failure refcount/lifetime asymmetry
correct?

If so, would one of the following directions be acceptable?

  1. An opt-in mechanism (for example, a module flag) for modules that
     are safe to isolate during init and whose init-failure path should
     wait for external references to drain.

  2. Treating MODULE_STATE_COMING as non-live for normal
     try_module_get() users, with some explicit escape hatch for the
     remaining subsystems that genuinely need self-entry during init.

Any guidance on the preferred direction would be much appreciated.

Best regards,
Mahanta Jambigi
