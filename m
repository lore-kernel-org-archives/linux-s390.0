Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617C471246;
	Mon, 21 Sep 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001269; cv=none; b=X7fJedxOIUu4kNO5FpjkMBMEGMURFlv9a8xAr/4gjkxWL4k8zOJh5U1FyUsXMaaMjmMoJBLrM8h5UJGXGZCgzgRHsBlD5sjSpKq785/iD8C3fxTi/eevuE5wmnXBzAJ03onLdq42Upi00cHMuBy5OQqdr+kRDYPOj97IjRXoEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001269; c=relaxed/simple;
	bh=2/0wGrB+8o4Y73yBsvH7MeZ+LxU4/IXLLLFr1CIZMRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDukN1CRxjAHJ6IhqkZoPuuDSYMb7OhAFg0t+yjc2I5ByuE6smyy4EIhjKIrhoCTm6raXiPv9/GuCaTlF3Df0MxOLn1/5fNTB2qWbJCqmrDyahWODyj+yWVk3cEBsOsTkJw4t24g4mv6iOmRzBFMdMWRISThYVROAQTY+spEjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LMTC2K4R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LMTC2K4R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LE5KtH1735437;
	Mon, 21 Sep 2026 14:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hPVcO2
	fTiSn9Cgqz2uE06qQzsAi1kuBDSpXamgeVd84=; b=LMTC2K4R3PSCNb6A9R3KVJ
	XMoJmTKJb0ZZTuwu6M0JOX+LpbjiLwZDOj0134nvnZ0lPEXN318gjrU0ztcKUeX1
	BWR3QeT6cyOdlVp0Q6FkkkHQxAxMl8+FSFcVZDuaRRcstdk/spvY+mPfyVDbHGNs
	0aLk2KXiiycfE+tfJ+f0KQXRrzgzGt9kp7pMAcBwHOHn78KyW4nVYUVKyf36oom/
	SfS2S7JOrQ/UFHdFTqQk6P4XGScQzqfuo8IyGYLZFWJS50VLwUn7OsEyRZ252k7f
	UibWBSktaGnSb1WTviBk5TN037aY8RhD8nWlBt3//PpcdDlJy5BEh2f8UsW6PvOg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs13d1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:34:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEIl1d1409274;
	Mon, 21 Sep 2026 14:34:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq5uk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 14:34:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LEYJr333096222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 14:34:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBF135805C;
	Mon, 21 Sep 2026 14:34:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07EA55805B;
	Mon, 21 Sep 2026 14:34:13 +0000 (GMT)
Received: from [9.39.17.204] (unknown [9.39.17.204])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 14:34:12 +0000 (GMT)
Message-ID: <2cd4adea-9b70-4951-be8b-40c1bcc7ecd6@linux.ibm.com>
Date: Mon, 21 Sep 2026 20:04:10 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
To: David Laight <david.laight.linux@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Daniel Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
 <20260918142241.55a6630a@pumpkin>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260918142241.55a6630a@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab1406e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YvAVsvIxy3shiQVTEy0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nTipSvQcDklONTshWfQZaWkCujhuVyll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX16sjj/DfXDpU
 mPvi3YyZDg2sLX4bjPbOR/0jYsZRGcr51Cb6fNWzigwtLPUb/NLcEDQL4Hjq9BIA+wdlRF7rgUk
 5wOG2wFie1ju4D06R6x+aZGrpMCUbl9CZOX0qYMW6kVGwrSySJxY5cvDXok6MQeyCwcLb15A0Un
 fiugiF4ybwDFxNgWbG4QYDdx9Knm4AOWdbpAYuvC3luVGIyUuQk3pbb2Spc1dghA6Eer690Y2EX
 IB+JAtVozO/VVqu5tH4zcC2dS0uUc9k59IaV9UbIEX5hxO+oUHfoY0yweMKS9PEPW+3c5AwfGWc
 vCWNc9VeKxcEtipWEzJscvm87GsHov2/pHp8L5IeexYpZXuMd8Eh+0f64UknOyfEXoG/hqtx7vk
 tgxh55pkmEBLYVANG6vVzuaTNUx01akmNkRVLseBuF0sXmIRLlEIC03ibLmhg5VhavtoBPyhvcG
 msLj7V391uelXo61DXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX8H4e7tHd9R5e
 J/iG9eIRMZ/932/tf0PduiI+h53ZGqOzbJ5p+YOrlox+4UJ1d4bkwsHFs4GIlbqYS7MoYjRt2Ry
 XJal1g8gEP8zieexIpd1zjAIZSwDeWw=
X-Proofpoint-GUID: vqkJvofST-7iaBHmYvcrgHmhxYpo8Svl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210205



On 18/09/26 6:52 pm, David Laight wrote:
> On Mon, 24 Aug 2026 11:43:46 +0530
> Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:
> 
>> Hi Luis, Petr, Daniel, Sami, Aaron,
>>
>> I'm writing to ask about what looks like a generic module-init failure
>> lifetime problem in the module loader. I ran into it while working on
>> the SMC networking module (net/smc/), but after several patch
>> iterations, it seems the root issue may belong in kernel/module/main.c
>> rather than in SMC itself. I'd appreciate your guidance on whether this
>> reading is correct, and if so, what fix direction would be preferred.
>>
>> THE ISSUE IN do_init_module()
>> =============================
>>
>> include/linux/module.h has a long-standing FIXME in module_is_live():
>>
>>     /* FIXME: It'd be nice to isolate modules during init, too, so they
>>        aren't used before they (may) fail. But presently too much code
>>        (IDE & SCSI) require entry into the module during init. */
>>     static inline bool module_is_live(struct module *mod)
>>     {
>>         return mod->state != MODULE_STATE_GOING;
>>     }
>>
>> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
>> can succeed once a module's __init is executing. If __init makes the
>> module externally reachable partway through and then later fails, the
>> failure path in do_init_module() appears to do:
> 
> It is rather worse that that.
> If sock_create() auto-loads a module (eg sctp) then nothing stops a second
> sock_create() entering the protocol code before the initialisation completes.
> That can be hit by two separate applications, I hit it from an out of tree
> kernel module and avoided the problem by putting a mutex() around the
> sock_create() call.
> 
> It might help by letting try_module_get(THIS_MODULE) always succeed
> while blocking other requests until initialisation completes.
> The code making the call must own a reference (otherwise the code could
> just disappear), and that reference stops the module being unloaded.
> That would let the initialisation code grab extra references (eg for
> a worker thread) without allowing other codes paths enter the
> part-initialised driver.

Thanks David — you're right that the race is broader. This patch
addresses only the UAF on the __init failure path: once we set
MODULE_STATE_GOING and call synchronize_rcu(), new callers see GOING and
fail; we then drain existing refs before free_module().

The concurrent-init race you describe — two callers entering
MODULE_STATE_COMING simultaneously during a successful init — is not
addressed here and would require changes to try_module_get() itself, as
you suggest. That is the long-standing FIXME in module_is_live() and is
a separate, larger change.
