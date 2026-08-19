Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3F397B0B;
	Wed, 19 Aug 2026 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128590; cv=none; b=Vx/DczJAbIFnR559p531AAkQ//c3O6mIbD3HjmHtzajGvGpMl1YYYN0d0FshZ9Q0v/lsm3ropeBRK3Qckpl3K917xj0W63gWJ12hyBkD++dFilXok32fKTvjuU0R5R2x5irsuQDc2crSar0Ga/YKQGzvDgYQxq9+3pPOI3m/+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128590; c=relaxed/simple;
	bh=STRShbCMtmopGcxxjsRbTV6EcOKAITzpD8TCcH1WPLk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EK977TZzTe11K3vaDM/sVW+hnwU7mXpWP4omsnhUgPT4ZmhQ05OYP7Dk2ZEDrX4cDr8PSJSWPymkfMn/vcLsm+a8n12gM9sG5jkbIzWpM4kbdJu5MEv6rac9CwCL06kr8b/4IVIS3ABw0Jw0dmEvW9ZtErHsuE4oclsKVizjIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c4hEIoM7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c4hEIoM7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WEuu2699982;
	Wed, 19 Aug 2026 08:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7ejQSUC29AO0h8RZQE+p0uESzUxUmD
	ZN3O38VSC5kbs=; b=c4hEIoM7RsDxjHjpkXSXNBfcu+Ce4QXMTwB6YwOyq4zl7W
	DAyah8NQYtm8eppe19/sgC1944Tnvli40Udsua6vTm/CSVjixrxFXl1SufS2juxO
	l0i/ukPG5BatIuvDhOaEo1YyLBRSZ3f6bhLeP55c3AiL3NISpTvt+4p3d/iHTcGn
	3HbYP26SgJfIemVyK298b6VzhMNHZ0v++qKkShIlXgrTK4v6zDyNF5fPo0cSerLB
	MDX2LvpLvRZmtLk6obBLm0CkxyNfHldxjY3DmbuqPje8pqx/+JacqEDbwPLNxeVi
	8VgvFkNIkTaINO0NCf6KhZlwia+dETFt5PtwYhwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42gep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:35:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8QdYO009559;
	Wed, 19 Aug 2026 08:35:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh7xgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:35:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8ZprS31392222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:35:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAE472004B;
	Wed, 19 Aug 2026 08:35:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790C620043;
	Wed, 19 Aug 2026 08:35:51 +0000 (GMT)
Received: from [9.224.87.221] (unknown [9.224.87.221])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:35:51 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------6f0JDZQk06NEhmlTczKJXPDd"
Message-ID: <58c95510-a245-495f-8df6-bbd70d71e637@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:35:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/25] unwind_user: Implement .eh_frame handling
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a856aed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=kLuRSTS-KpdjK6pdn6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=u9c9Ard3bLVWCFqh_P4A:9 a=B2y7HmGcmWMA:10
X-Proofpoint-ORIG-GUID: lSUYlDaE7l7yDRH6AABU6h1WD-HPgTBL
X-Proofpoint-GUID: 5gINd-piAVU7hq12oWhk6t9IIz-H5bRh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX7MQUOrxbiuhM
 HompgrR+qqNeX0b79fIKWPWCRXYcbsihh5z4GzabQXsOpZmfLbmj/0Q0fuOnIK3Vz5wy5hhVjBZ
 qWsJFSWvF0i7YuFPbwt/hA6Q9QXjkB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX/tT+95nGAe3D
 O6XLFr17eiDziz6TsIAn94x2OQKmwrPVWDIHJXILyXj1E6wUndKY8a8y8LBI0YMzzYMMK4U7von
 hPiPLbKM830I60g8Yv2w/DqKWfVsNivYrGX0kxVn5PyqesJjinmQ/El3mKXahDxkfolTd/Kf7ul
 HlU8gEYJqOWesCcLVEaYyA4O2JIzBheOQ8f51M1sOIuPGM+G51+R+5nn9cDQTrf9j+Yru/Lb7be
 ROKWvJ4okvJZ0YvMRyEAIajwVnc5Q0s8vhlI3PkywMMMSxk30x03M6wZcZHD9YyWAFt0T44H45i
 aB6zlEm29xCbfBd1IXCrX7iNURG0lnOHxuvBuYbdHI3nuf1QAy96f/Bot/zPZ1TJ/ZMEYl5suTf
 6RGMouoBPhNKwDjPysdoU/l4AT9i/6YySlhysiAg367DbQG0AZbIDOy8wllUhJonh9rqUx5Ampj
 nT8ahQhGxt+dNozZk0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190063

This is a multi-part message in MIME format.
--------------6f0JDZQk06NEhmlTczKJXPDd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/2026 4:49 PM, Jens Remus wrote:
> This series adds support for parsing DWARF Call Frame Information (CFI)
> from the .eh_frame_hdr and .eh_frame sections of user space ELF files.

I am working on Sashiko's AI review feedback and will send a RFC v2
soon.

> Patch 25 adds a prctl() interface for (un)registering .eh_frame_hdr
> sections for shared libraries.  I will send a related test-patch for
> Glibc separately.

Meanwhile find attached a Glibc 2.44 test patch that registers
.eh_frame_hdr sections referenced by GNU_EH_FRAME in shared libraries
with the kernel.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

--------------6f0JDZQk06NEhmlTczKJXPDd
Content-Type: text/plain; charset=UTF-8;
 name="glibc-2.44_register-GNU_EH_FRAME.patch"
Content-Disposition: attachment;
 filename="glibc-2.44_register-GNU_EH_FRAME.patch"
Content-Transfer-Encoding: base64

RnJvbSAxNTkwMDNlZjBlZjIxMDdkZGM4ZWM4ZmQ4ZTZjZTA2MTk4ZWJiZmRjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIFJlbXVzIDxqcmVtdXNAbGludXguaWJtLmNv
bT4KRGF0ZTogV2VkLCAxOSBBdWcgMjAyNiAxMDoxNTo1MyArMDIwMApTdWJqZWN0OiBbUEFU
Q0hdIFRFU1Q6IGdsaWJjOiBSZWdpc3RlciBHTlVfRUhfRlJBTUUgUEhEUnMgdG8gdGhlIGtl
cm5lbAoKVGhlIGtlcm5lbCBkb2VzIG5vdCBoYXZlIGRpcmVjdCB2aXNpYmlsaXR5IHRvIHRo
ZSBFTEYgY29udGVudHMgb2YKc2hhcmVkIGxpYnJhcmllcy4gIEluIHRoZSBkeW5hbWljIGxp
bmtlciByZWdpc3RlciBhbmQgdW5yZWdpc3RlcgouZWhfZnJhbWVfaGRyIHNlY3Rpb25zIHJl
ZmVyZW5jZWQgYnkgR05VX0VIX0ZSQU1FIHByb2dyYW0gaGVhZGVycwp2aWEgYSBwcm9wb3Nl
ZCBwcmN0bCgpIGludGVyZmFjZSBbMV0gdG8gdGhlIGtlcm5lbCwgc28gaXQga25vd3MKd2hl
cmUgdG8gZmluZCB0aGVzZSBmb3Igc3RhY2t0cmFjaW5nIHB1cnBvc2VzLgoKUmVnaXN0ZXIg
LmVoX2ZyYW1lX2hkciBzZWN0aW9ucyBkdXJpbmcgc2hhcmVkIG9iamVjdCBsb2FkaW5nIGFu
ZApkdXJpbmcgc2V0dXAgb2YgVkRTTy4gIFVucmVnaXN0ZXIgdGhlbSBkdXJpbmcgdW5tYXBw
aW5nLiAgVXNlcwpwcm9wb3NlZCBQUl97UkVHSVNURVJ8VU5SRUdJU1RFUn1fRUhfRlJBTUUg
cHJjdGwuCgpCYXNlZCBvbiBKb3NoIFBvaW1ib2V1ZidzIHJlc3BlY3RpdmUgR05VX1NGUkFN
RSB0ZXN0IHBhdGNoLgoKWzFdOiBbUkZDIFBBVENIIHYxIDI1LzI1XSB1bndpbmRfdXNlci9l
aF9mcmFtZTogQWRkIHByY3RsKCkgaW50ZXJmYWNlCiAgICAgZm9yICh1bilyZWdpc3Rlcmlu
ZyAuZWhfZnJhbWVfaGRyIHNlY3Rpb25zLAogICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI2MDgxODE0NDk1NC4yMzIwMzc4LTI2LWpyZW11c0BsaW51eC5pYm0uY29tLwoK
WyBUaGlzIHBhdGNoIGlzIGZvciB0ZXN0IHB1cnBvc2VzIG9ubHkuIF0KClNpZ25lZC1vZmYt
Ynk6IEplbnMgUmVtdXMgPGpyZW11c0BsaW51eC5pYm0uY29tPgotLS0KIGVsZi9kbC1sb2Fk
LmMgICAgICAgICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KIGVsZi9kbC11bm1hcC1zZWdtZW50cy5oIHwgMzAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBlbGYvc2V0dXAtdmRzby5oICAgICAgICB8IDQwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbmsuaCAgICAgICAgICB8ICAzICsr
KwogNCBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2VsZi9kbC1sb2FkLmMgYi9lbGYvZGwtbG9hZC5jCmluZGV4IDk1NDA0
YWRhZTk0Mi4uMTBlZjM2NWJjODFiIDEwMDY0NAotLS0gYS9lbGYvZGwtbG9hZC5jCisrKyBi
L2VsZi9kbC1sb2FkLmMKQEAgLTI5LDYgKzI5LDcgQEAKICNpbmNsdWRlIDxiaXRzL3dvcmRz
aXplLmg+CiAjaW5jbHVkZSA8c3lzL21tYW4uaD4KICNpbmNsdWRlIDxzeXMvcGFyYW0uaD4K
KyNpbmNsdWRlIDxzeXMvcHJjdGwuaD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgogI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGdudS9saWItbmFtZXMuaD4KQEAgLTY1LDYg
KzY2LDIzIEBACiAKICNkZWZpbmUgU1RSSU5HKHgpIF9fU1RSSU5HICh4KQogCisjaWZuZGVm
IF9GVVRVUkVfTElOVVhfRUhfRlJBTUUKKyNkZWZpbmUgX0ZVVFVSRV9MSU5VWF9FSF9GUkFN
RQorCisvKiBGcm9tIDxsaW51eC9wcmN0bC5oPi4gICovCisjZGVmaW5lIFBSX1JFR0lTVEVS
X0VIX0ZSQU1FIDgyCisjZGVmaW5lIFBSX1VOUkVHSVNURVJfRUhfRlJBTUUgODMKKworLyog
RnJvbSA8bGludXgvZWhfZnJhbWUuaD4uICAqLworc3RydWN0IGVoX2ZyYW1lX3NldHVwIHsK
KyAgX191NjQgZWhfZnJhbWVfaGRyX3N0YXJ0OworICBfX3U2NCBlaF9mcmFtZV9oZHJfc2l6
ZTsKKyAgX191NjQgdGV4dF9zdGFydDsKKyAgX191NjQgdGV4dF9zaXplOworfTsKKworI2Vu
ZGlmIC8qIF9GVVRVUkVfTElOVVhfRUhfRlJBTUUgICovCisKIAogLyogVGhpcyBpcyB0aGUg
ZGVjb21wb3NlZCBMRF9MSUJSQVJZX1BBVEggc2VhcmNoIHBhdGguICAqLwogc3RydWN0IHJf
c2VhcmNoX3BhdGhfc3RydWN0IF9fcnRsZF9lbnZfcGF0aF9saXN0IGF0dHJpYnV0ZV9yZWxy
bzsKQEAgLTEwOTYsNiArMTExNCwxMSBAQCBfZGxfbWFwX29iamVjdF9zY2FuX3BoZHJzIChz
dHJ1Y3QgZGxfcHRfbG9hZF9pdGVyYXRvciAqaXQsCiAJICBsLT5sX3JlbHJvX2FkZHIgPSBw
aC0+cF92YWRkcjsKIAkgIGwtPmxfcmVscm9fc2l6ZSA9IHBoLT5wX21lbXN6OwogCSAgYnJl
YWs7CisKKwljYXNlIFBUX0dOVV9FSF9GUkFNRToKKwkgIGwtPmxfZWhfZnJhbWVfc3RhcnQg
PSBwaC0+cF92YWRkcjsKKwkgIGwtPmxfZWhfZnJhbWVfc2l6ZSAgPSBwaC0+cF9tZW1zejsK
KwkgIGJyZWFrOwogCX0KICAgICB9CiAKQEAgLTEzODQsMTMgKzE0MDcsMzQgQEAgY2Fubm90
IGVuYWJsZSBleGVjdXRhYmxlIHN0YWNrIGFzIHNoYXJlZCBvYmplY3QgcmVxdWlyZXMiKTsK
ICAgaWYgKGwtPmxfdGxzX2luaXRpbWFnZSAhPSBOVUxMKQogICAgIGwtPmxfdGxzX2luaXRp
bWFnZSA9ICh2b2lkKikoKHVpbnRwdHJfdClsLT5sX3Rsc19pbml0aW1hZ2UgKyBsLT5sX2Fk
ZHIpOwogCisgIC8qIEFkanVzdCB0aGUgYWRkcmVzcyBvZiB0aGUgLmVoX2ZyYW1lX2hkciBz
dGFydCBhZGRyZXNzLiAgKi8KKyAgaWYgKGwtPmxfZWhfZnJhbWVfc3RhcnQgIT0gMCkKKyAg
ICBsLT5sX2VoX2ZyYW1lX3N0YXJ0ICs9IGwtPmxfYWRkcjsKKwogICAvKiBQcm9jZXNzIHBy
b2dyYW0gaGVhZGVycyBhZ2FpbiBhZnRlciBsb2FkIHNlZ21lbnRzIGFyZSBtYXBwZWQgaW4K
ICAgICAgY2FzZSBwcm9jZXNzaW5nIHJlcXVpcmVzIGFjY2Vzc2luZyB0aG9zZSBzZWdtZW50
cy4gIFNjYW4gcHJvZ3JhbQogICAgICBoZWFkZXJzIGJhY2t3YXJkIHNpbmNlIFBUX0dOVV9Q
Uk9QRVJUWSBpcyBjbG9zZSB0byB0aGUgZW5kIG9mCiAgICAgIHByb2dyYW0gaGVhZGVycy4g
ICovCiAgIGZvciAocGggPSAmbC0+bF9waGRyW2wtPmxfcGhudW1dOyBwaCAhPSBsLT5sX3Bo
ZHI7IC0tcGgpCi0gICAgaWYgKHBoWy0xXS5wX3R5cGUgPT0gUFRfR05VX1BST1BFUlRZKQor
ICAgIHN3aXRjaCAocGhbLTFdLnBfdHlwZSkKICAgICAgIHsKKyAgICAgIGNhc2UgUFRfTE9B
RDoKKwkgIGlmIChsLT5sX2VoX2ZyYW1lX3N0YXJ0ICE9IDAKKwkgICAgICAmJiBwaFstMV0u
cF9mbGFncyAmIFBGX1gpCisJICAgIHsKKwkgICAgICBFbGZXKEFkZHIpIHRleHRfc3RhcnQg
PSBsLT5sX2FkZHIgKyBwaFstMV0ucF92YWRkcjsKKwkgICAgICBzaXplX3QgdGV4dF9zaXpl
ICAgICAgPSBwaFstMV0ucF9tZW1zejsKKwkgICAgICBzdHJ1Y3QgZWhfZnJhbWVfc2V0dXAg
ZGF0YSA9IHsKKwkJLmVoX2ZyYW1lX2hkcl9zdGFydCA9IGwtPmxfZWhfZnJhbWVfc3RhcnQs
CisJCS5laF9mcmFtZV9oZHJfc2l6ZSAgPSBsLT5sX2VoX2ZyYW1lX3NpemUsCisJCS50ZXh0
X3N0YXJ0ICAgICAgICAgPSB0ZXh0X3N0YXJ0LAorCQkudGV4dF9zaXplICAgICAgICAgID0g
dGV4dF9zaXplLAorCSAgICAgIH07CisKKwkgICAgICBfX3ByY3RsKFBSX1JFR0lTVEVSX0VI
X0ZSQU1FLCAmZGF0YSwgc2l6ZW9mKGRhdGEpLCAwLCAwKTsKKwkgICAgfQorCWJyZWFrOwor
ICAgICAgY2FzZSBQVF9HTlVfUFJPUEVSVFk6CiAJX2RsX3Byb2Nlc3NfcHRfZ251X3Byb3Bl
cnR5IChsLCBmZCwgJnBoWy0xXSk7CiAJYnJlYWs7CiAgICAgICB9CmRpZmYgLS1naXQgYS9l
bGYvZGwtdW5tYXAtc2VnbWVudHMuaCBiL2VsZi9kbC11bm1hcC1zZWdtZW50cy5oCmluZGV4
IGMzZTQ2ZDUwZWM3Mi4uZWFlMDg0M2U4NWE4IDEwMDY0NAotLS0gYS9lbGYvZGwtdW5tYXAt
c2VnbWVudHMuaAorKysgYi9lbGYvZGwtdW5tYXAtc2VnbWVudHMuaApAQCAtMjEsNiArMjEs
MjQgQEAKIAogI2luY2x1ZGUgPGxpbmsuaD4KICNpbmNsdWRlIDxzeXMvbW1hbi5oPgorI2lu
Y2x1ZGUgPHN5cy9wcmN0bC5oPgorCisjaWZuZGVmIF9GVVRVUkVfTElOVVhfRUhfRlJBTUUK
KyNkZWZpbmUgX0ZVVFVSRV9MSU5VWF9FSF9GUkFNRQorCisvKiBGcm9tIDxsaW51eC9wcmN0
bC5oPi4gICovCisjZGVmaW5lIFBSX1JFR0lTVEVSX0VIX0ZSQU1FIDgyCisjZGVmaW5lIFBS
X1VOUkVHSVNURVJfRUhfRlJBTUUgODMKKworLyogRnJvbSA8bGludXgvZWhfZnJhbWUuaD4u
ICAqLworc3RydWN0IGVoX2ZyYW1lX3NldHVwIHsKKyAgX191NjQgZWhfZnJhbWVfaGRyX3N0
YXJ0OworICBfX3U2NCBlaF9mcmFtZV9oZHJfc2l6ZTsKKyAgX191NjQgdGV4dF9zdGFydDsK
KyAgX191NjQgdGV4dF9zaXplOworfTsKKworI2VuZGlmIC8qIF9GVVRVUkVfTElOVVhfRUhf
RlJBTUUgICovCiAKIC8qIF9kbF9tYXBfc2VnbWVudHMgZW5zdXJlcyB0aGF0IGFueSB3aG9s
ZSBwYWdlcyBpbiBnYXBzIGJldHdlZW4gc2VnbWVudHMKICAgIGFyZSBmaWxsZWQgaW4gd2l0
aCBQUk9UX05PTkUgbWFwcGluZ3MuICBTbyB3ZSBjYW4ganVzdCB1bm1hcCB0aGUgd2hvbGUK
QEAgLTI5LDYgKzQ3LDE4IEBACiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQKIF9kbF91
bm1hcF9zZWdtZW50cyAoc3RydWN0IGxpbmtfbWFwICpsKQogeworICBpZiAobC0+bF9laF9m
cmFtZV9zdGFydCAhPSAwKQorICAgIHsKKyAgICAgIHN0cnVjdCBlaF9mcmFtZV9zZXR1cCBk
YXRhID0geworCS5laF9mcmFtZV9oZHJfc3RhcnQgPSBsLT5sX2VoX2ZyYW1lX3N0YXJ0LAor
CS5laF9mcmFtZV9oZHJfc2l6ZSAgPSAwLAorCS50ZXh0X3N0YXJ0ICAgICAgICAgPSAwLAor
CS50ZXh0X3NpemUgICAgICAgICAgPSAwLAorICAgICAgfTsKKworICAgICAgX19wcmN0bChQ
Ul9VTlJFR0lTVEVSX0VIX0ZSQU1FLCAmZGF0YSwgc2l6ZW9mKGRhdGEpLCAwLCAwKTsKKyAg
ICB9CisKICAgX19tdW5tYXAgKCh2b2lkICopIGwtPmxfbWFwX3N0YXJ0LCBsLT5sX21hcF9l
bmQgLSBsLT5sX21hcF9zdGFydCk7CiB9CiAKZGlmZiAtLWdpdCBhL2VsZi9zZXR1cC12ZHNv
LmggYi9lbGYvc2V0dXAtdmRzby5oCmluZGV4IDBkYmE3MDcyZDUzYi4uODM0MTFjMWFhMzk2
IDEwMDY0NAotLS0gYS9lbGYvc2V0dXAtdmRzby5oCisrKyBiL2VsZi9zZXR1cC12ZHNvLmgK
QEAgLTE2LDYgKzE2LDI1IEBACiAgICBMaWNlbnNlIGFsb25nIHdpdGggdGhlIEdOVSBDIExp
YnJhcnk7IGlmIG5vdCwgc2VlCiAgICA8aHR0cHM6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+
LiAgKi8KIAorI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgorCisjaWZuZGVmIF9GVVRVUkVfTElO
VVhfRUhfRlJBTUUKKyNkZWZpbmUgX0ZVVFVSRV9MSU5VWF9FSF9GUkFNRQorCisvKiBGcm9t
IDxsaW51eC9wcmN0bC5oPi4gICovCisjZGVmaW5lIFBSX1JFR0lTVEVSX0VIX0ZSQU1FIDgy
CisjZGVmaW5lIFBSX1VOUkVHSVNURVJfRUhfRlJBTUUgODMKKworLyogRnJvbSA8bGludXgv
ZWhfZnJhbWUuaD4uICAqLworc3RydWN0IGVoX2ZyYW1lX3NldHVwIHsKKyAgX191NjQgZWhf
ZnJhbWVfaGRyX3N0YXJ0OworICBfX3U2NCBlaF9mcmFtZV9oZHJfc2l6ZTsKKyAgX191NjQg
dGV4dF9zdGFydDsKKyAgX191NjQgdGV4dF9zaXplOworfTsKKworI2VuZGlmIC8qIF9GVVRV
UkVfTElOVVhfRUhfRlJBTUUgICovCisKIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2F0dHJpYnV0
ZV9fICgoYWx3YXlzX2lubGluZSkpCiBzZXR1cF92ZHNvIChzdHJ1Y3QgbGlua19tYXAgKm1h
aW5fbWFwIF9fYXR0cmlidXRlX18gKCh1bnVzZWQpKSwKIAkgICAgc3RydWN0IGxpbmtfbWFw
ICoqKmZpcnN0X3ByZWxvYWQgX19hdHRyaWJ1dGVfXyAoKHVudXNlZCkpKQpAQCAtNTYsNiAr
NzUsMTQgQEAgc2V0dXBfdmRzbyAoc3RydWN0IGxpbmtfbWFwICptYWluX21hcCBfX2F0dHJp
YnV0ZV9fICgodW51c2VkKSksCiAJICAgICAgaWYgKHBoLT5wX3ZhZGRyICsgcGgtPnBfbWVt
c3ogPj0gbC0+bF9tYXBfZW5kKQogCQlsLT5sX21hcF9lbmQgPSBwaC0+cF92YWRkciArIHBo
LT5wX21lbXN6OwogCSAgICB9CisJICBlbHNlIGlmIChwaC0+cF90eXBlID09IFBUX0dOVV9F
SF9GUkFNRSkKKwkgICAgeworCSAgICAgIGlmICghIGwtPmxfZWhfZnJhbWVfc3RhcnQpCisJ
CXsKKwkJICBsLT5sX2VoX2ZyYW1lX3N0YXJ0ID0gcGgtPnBfdmFkZHI7CisJCSAgbC0+bF9l
aF9mcmFtZV9zaXplICA9IHBoLT5wX21lbXN6OworCQl9CisJICAgIH0KIAkgIGVsc2UKIAkg
ICAgLyogVGhlcmUgbXVzdCBiZSBubyBUTFMgc2VnbWVudC4gICovCiAJICAgIGFzc2VydCAo
cGgtPnBfdHlwZSAhPSBQVF9UTFMpOwpAQCAtNzgsNiArMTA1LDE5IEBAIHNldHVwX3Zkc28g
KHN0cnVjdCBsaW5rX21hcCAqbWFpbl9tYXAgX19hdHRyaWJ1dGVfXyAoKHVudXNlZCkpLAog
ICAgICAgbC0+bF9sb2NhbF9zY29wZVswXS0+cl9ubGlzdCA9IDE7CiAgICAgICBsLT5sX2xv
Y2FsX3Njb3BlWzBdLT5yX2xpc3QgPSAmbC0+bF9yZWFsOwogCisgICAgICBpZiAobC0+bF9l
aF9mcmFtZV9zdGFydCAhPSAwKQorCXsKKwkgIGwtPmxfZWhfZnJhbWVfc3RhcnQgKz0gbC0+
bF9hZGRyOworCisJICBzdHJ1Y3QgZWhfZnJhbWVfc2V0dXAgZGF0YSA9IHsKKwkgICAgLmVo
X2ZyYW1lX2hkcl9zdGFydCA9IGwtPmxfZWhfZnJhbWVfc3RhcnQsCisJICAgIC5laF9mcmFt
ZV9oZHJfc2l6ZSAgPSBsLT5sX2VoX2ZyYW1lX3NpemUsCisJICAgIC50ZXh0X3N0YXJ0ICAg
ICAgICAgPSBsLT5sX21hcF9zdGFydCwKKwkgICAgLnRleHRfc2l6ZSAgICAgICAgICA9IGwt
PmxfbWFwX2VuZCAtIGwtPmxfbWFwX3N0YXJ0LAorCSAgfTsKKwkgIF9fcHJjdGwoUFJfUkVH
SVNURVJfRUhfRlJBTUUsICZkYXRhLCBzaXplb2YoZGF0YSksIDAsIDApOworCX0KKwogICAg
ICAgLyogTm93IHRoYXQgd2UgaGF2ZSB0aGUgaW5mbyBoYW5keSwgdXNlIHRoZSBEU08gaW1h
Z2UncyBzb25hbWUKIAkgc28gdGhpcyBvYmplY3QgY2FuIGJlIGxvb2tlZCB1cCBieSBuYW1l
LiAgKi8KICAgICAgIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGluay5oIGIvaW5jbHVkZS9s
aW5rLmgKaW5kZXggOGY4NTFkMjIxMmRmLi5iOWVlNDY3NGFjNjkgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGluay5oCisrKyBiL2luY2x1ZGUvbGluay5oCkBAIC0zNDUsNiArMzQ1LDkgQEAg
c3RydWN0IGxpbmtfbWFwCiAgICAgRWxmVyhBZGRyKSBsX3JlbHJvX2FkZHI7CiAgICAgc2l6
ZV90IGxfcmVscm9fc2l6ZTsKIAorICAgIEVsZlcoQWRkcikgbF9laF9mcmFtZV9zdGFydDsK
KyAgICBzaXplX3QgbF9laF9mcmFtZV9zaXplOworCiAgICAgdW5zaWduZWQgbG9uZyBsb25n
IGludCBsX3NlcmlhbDsKICAgfTsKIAotLSAKMi41My4wCgo=

--------------6f0JDZQk06NEhmlTczKJXPDd--

