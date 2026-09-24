Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316D4BD10B;
	Thu, 24 Sep 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275947; cv=none; b=q4/B+w3Quszre1GM2vIttHzMcmMp3K6WhusDYX1L/7rowuET+v4A6k8kDdpvLqFCWL5CeIaIHgi7G+fXL14993fLJZ+V1oEE9+8lLDvWAUyOvft5ii4qfEobQ2DJI5YWEy1xoUD417seeDecXuL/jJtBf69pYdOUZnHv9uSGotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275947; c=relaxed/simple;
	bh=mMkmqJxcLB/vi7uEzUZg0E80sbYNmhcN5SuNZtyH0eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsY4rdiCAfjXN1qMBd8tEDuD7EFr4k6p4KfM+gTM/8VwNyWBHuZHFhGeFN1+Nm3hEs6q6cbT1BCgu4QrwEuCFUyh+g8hbYE00oG+ux86xNhBJ014wUULVzvvvnbe1hFQ2oXzKSHKTWLAcYoAJk6t1MeM0ka6u7JWDEC8ufBAxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rnQyO+Hy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rnQyO+Hy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5PV91518689;
	Thu, 24 Sep 2026 18:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vdQRl6
	2fxu/UVrUd/xr75NlbS6XBpIwn+GbncBzcmWU=; b=rnQyO+HyJ9y9BZ6WROB7ko
	5YezlizXeY8SbQ0WgBXUJuODwdg7kpHG8mmyrcT4F/BGlntS1FVkxXi6T227ww0W
	eYQyZgthitMXgwAK5APb2oDkU+AzyEM1VSWT6CO8rYR4bek8IetZx7wKGEp40ide
	G1zyca1zvvu+/tGAwy0mvQSDf7zn28TxO8vj1aIaHhSIAtkqMUQwBd/Bvkw/AlTe
	n/hzOzNwE/GwzhxeJJSLM50iWKuis8LOAJ7PUGJScLXYV0Jneg4DIRAkDb7CQkSn
	Y6t70ZeM5s4cqsJIOW/Zzbm7e+34U8Sv92LiPXOV3PGhOLrplnkZlfFN9QaK1pKg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqt5r6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 18:52:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIlXeN1233804;
	Thu, 24 Sep 2026 18:52:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ebf94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 18:52:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OIq15s43254268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 18:52:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD10420043;
	Thu, 24 Sep 2026 18:52:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6440C2004B;
	Thu, 24 Sep 2026 18:52:01 +0000 (GMT)
Received: from [9.111.162.93] (unknown [9.111.162.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 18:52:01 +0000 (GMT)
Message-ID: <d0c5ed89-f782-4acf-8c4c-4626f4be650a@linux.ibm.com>
Date: Thu, 24 Sep 2026 20:52:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/iucv: require IUCV for AF_IUCV sockets
To: netdev-bot+sashiko@kernel.org, hppiscas@163.com
Cc: twinkler@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com
References: <20260920034503.17322-1-hppiscas@163.com>
 <178996250579.2160803.3689804935882322466@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <178996250579.2160803.3689804935882322466@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab57156 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=uFMUYbXHekByYFyzfJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3NiBTYWx0ZWRfX3nG3YAqhF7vC
 uwy2809Lf+hAF8kQTrS7R3jlVIFsv/v1YjMBqfKg5zK7VxI7+5mwVS52AbB19i1qzIEi3+ChSDe
 SnYQExzM1iWvkVT5p42GgVdsc8bz1S7JxSRDph4wXrovHwiKTmjiz2WoXYF3nKnrbKBbFkiEJ1g
 EtY/M4A1fvTNwxXyi2wysb64gf7TUrKSbIYdEMGN8UP89QyX4QLXhHewY4Hh4nX4Pmxmx9XELYl
 fYwrHkP2mapFQqzm8h91ugtFold7lBQdeDGGSfMskn1rIOShPF5URJqYJznr/efQVFsA6YYJ1I1
 tWAzEAbLEozfBhZdnOivp8XHskCLYgdwvmXnm4+0ClfX2wqg8kX4bqJX03+xuy7hZt2dWLH7eY4
 UQ72PP94+lXiNpPzw4zq5Ck9ys1Idna/3RjCnkmAZ9GAGv7TAbQUjkR74CsaZunStsFp4zyKGOP
 jQ8mYckTXr8PIZI9gEw==
X-Proofpoint-ORIG-GUID: ahZbbv18zXPzYNXVilYTQdAAQXluOaxR
X-Proofpoint-GUID: cqgkRB0Q2fJ9CIs_6JkJP6cDIgEsIo7_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3NiBTYWx0ZWRfX/3h77XWMWMBH
 Mwl6Qn/xcGVho+qCQt5T7pdE7O3kWunYniEiQJxv4wyEu7v4708j2Oml3/6G3XR6t1XZeMBj7Ms
 KqP52kTaN7/01L46HvqvSwCVac3HLkU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240076



On 21.09.26 05:48, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] net/iucv/Kconfig: replacing `depends on S390` with `depends on
>   IUCV` for AFIUCV reverts, without disclosure, the design intent of the…
> 
> --

Pengpeng Hou,
thank you for your contribution.

tl,dr: I think Sashiko is right and I found another issue with this patch when testing.
Let me know, if you want me to continue with a Reported-by you, or if you want to work
on a v4. In that case see my comments below.


> 
> net/iucv: require IUCV for AF_IUCV sockets
> 
> This changes the AFIUCV Kconfig symbol from "depends on S390" to
> "depends on IUCV" so that AFIUCV can no longer be enabled when the IUCV
> core is disabled. It replaces the v2 approach of always descending into
> net/iucv from net/Makefile.
> 
> Previous posting referenced in the patch:
> https://lore.kernel.org/all/20260815135456.53684-1-pengpeng@iscas.ac.cn/
> 
>> diff --git a/net/iucv/Kconfig b/net/iucv/Kconfig
>> index 5cfddc9c6498..2686d795cc2f 100644
>> --- a/net/iucv/Kconfig
>> +++ b/net/iucv/Kconfig
>> @@ -9,7 +9,7 @@ config IUCV
>>  	  communication link between VM guests.
>>  
>>  config AFIUCV
>> -	depends on S390
>> +	depends on IUCV
> 
> [Severity: Medium]
> Is the stated rationale accurate here?  The commit message says:
> 
>   "Independently entering the directory is not sufficient: AF_IUCV also
>    relies on the IUCV implementation."
> 
> Looking at afiucv_init() in net/iucv/af_iucv.c, the only reference to
> the IUCV core is compile-time guarded:
> 
> 	if (machine_is_vm() && IS_ENABLED(CONFIG_IUCV)) {
> 		...
> 		pr_iucv = &iucv_if;
> 	} else {
> 		memset(&iucv_userid, 0, sizeof(iucv_userid));
> 		pr_iucv = NULL;
> 	}
> 
> and iucv_sock_alloc() treats a NULL provider as a supported mode:
> 
> 	if (pr_iucv)
> 		iucv->transport = AF_IUCV_TRANS_IUCV;
> 	else
> 		iucv->transport = AF_IUCV_TRANS_HIPER;
> 
> The other iucv_* users in af_iucv.c are iucv_path_alloc() and
> iucv_path_free(), which are static inline wrappers around kzalloc_obj()
> and kfree() in include/net/iucv/iucv.h.  Does af_iucv.o then have any
> link-time dependency on the IUCV core at all with CONFIG_IUCV=n?
> 

I actually tested IUCV=N, AF_IUCV=M with your v2 and it worked fine.
So it's not that "AF_IUCV also relies on the IUCV implementation";

In case of IUCV=M, AF_IUCV=Y
it's that 'IS_ENABLED(CONFIG_IUCV)' causes the issue of
	undefined reference to `iucv_if'
when IUCV is a module and AF_IUCV is built in.



> The reason af_iucv.o is not built in that configuration appears to be
> only the traversal rule in net/Makefile:
> 
> 	obj-$(CONFIG_IUCV)		+= iucv/
> 
> Also, c69748d1c9b5, named in the Fixes: tag, deliberately changed
> "depends on IUCV" to "depends on S390" together with
> "def_tristate m if QETH_L3 || IUCV" so that AF_IUCV could be enabled for
> the HiperSockets transport alone.  Since this patch makes the AFIUCV
> symbol invisible for every CONFIG_IUCV=n configuration, is the word
> "Restore" describing the right direction, and could the commit message
> say explicitly that the HiperSockets-only configuration is being dropped
> rather than fixed?


I agree it seems, it was the intention, that AF_IUCV over HiperSockets,
could be used independently of IUCV over z/VM's TRANS_IUCV.
However I never heard of any usecase where such a kernel was built,
typically you want both on s390.
That's why I proposed the shortcut.


> 
> One further consequence worth spelling out: iucv_init() in
> net/iucv/iucv.c bails out early on non-z/VM systems:
> 
> 	if (!machine_is_vm()) {
> 		rc = -EPROTONOSUPPORT;
> 		goto out;
> 	}
> 
> so on an LPAR, does a modular IUCV still work as the provider that
> AFIUCV=m now depends on, or does this effectively force CONFIG_IUCV=y
> for HiperSockets AF_IUCV users?
> 


Actually even with your v2 IUCV=M, AF_IUCV=M builds fine in an LPAR,
but modprobe returns with
modprobe: ERROR: could not insert 'af_iucv': Protocol not supported	(not expected)
modprobe: ERROR: could not insert 'iucv': Protocol not supported   	(expected)

Is this a result of
> 	if (machine_is_vm() && ...
>		err = -EPROTONOSUPPORT;

I don't fully understand it yet.

But that combination can be defined, even with your v3, so we have another open issue here.

I definitively need to test all possible combinations! (Should have done that earlier, I admit)



>>  	def_tristate m if QETH_L3 || IUCV
>>  	prompt "AF_IUCV Socket support (S390 - z/VM and HiperSockets transport)"
>>  	help
> 
> [Severity: Low]
> With "depends on IUCV" in place, IUCV is always y or m whenever AFIUCV
> is visible, so the QETH_L3 term of
> 
> 	def_tristate m if QETH_L3 || IUCV
> 
> can never decide the default any more.  Should the default clause be
> reduced to just "def_tristate m"?
> 
> Similarly, the prompt and the help text below still present z/VM and
> HiperSockets as separable transports:
> 
> 	  Select this option if you want to use AF_IUCV socket applications
> 	  based on z/VM inter-user communication vehicle or based on
> 	  HiperSockets.
> 
> Do these need updating too, now that the HiperSockets-only case can no
> longer be configured?  The IS_ENABLED(CONFIG_IUCV) test in
> afiucv_init() also becomes permanently true after this change.

Valid thoughts, in case we go with the 'depends' option.




