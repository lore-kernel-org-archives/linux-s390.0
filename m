Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1C478E5E;
	Thu, 13 Aug 2026 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630010; cv=none; b=YBIzYZJdCqi2Bb3SDumYM10RqmoWYlbatYTyKXe4B9jLTxPYuaVj2h1Y+cnUyZH4wG+DnvMO/TtwdrqxrVI01uYEus2trsG9Y3LVMPgVowIzT/9cRr2GEgDwxsVP2BS+zPCsv6HEnW2NqAdZI/qPL9YLH5GRhSPWuxV3QxkhdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630010; c=relaxed/simple;
	bh=rD9LDociC7T0XYdB9HYNauKiuze2lAsoldRHMeOEEvE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IJKMas0EuFO1vh5MiLcrBj9glDaceZh+mW4RWkPG4vfsVJbTb4XRqeVI+eI20zSHIPh3njbPt8kJ85tkzD2ksvPrA/mpp/pMk3bq8zBqKBvrIVxPF90CfhfOSSyMJaG1Zx6a5y91Qi4+F6v8Lz6SL6nWJZYTCZE2HUCi/fOcGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mt4li9+R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mt4li9+R"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCWIEN1237843;
	Thu, 13 Aug 2026 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=i6RAXDsCE/+wpriK+EbpTJ7EcpWbabjPzXrrxeX0sxs=; b=Mt4li9+R31KQ
	XbH1TsJTNzK5PIIx0BgRdVd54TtFaXuhw9tSohTIykjRLbRhCy/XQBwnJZRFchFv
	dHmVS4Z58DXPRkgDPJe4PmTV0eosBHTG9+2WQJvXgsVCgX4tDEH3wRyStRzvMSx1
	I6+GxjPQP29PIj8n3ov6V7Wg6opTXQebOiFPKtEl/swi4Mx6MIkq2+D/xsLlzCYX
	GLmx0LU1+YZYKpFyjpRAsK5bLGVzWpM5+hvGaUd/KJpn0ek3weWWOR+GQ9+/IGdY
	1w5oQXnPxTSFMVNituVFhA3W273HGFVoCtL2FRYxeVHczvCTVX5SADgbkYtcl221
	t6GXPRAsxw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb240kcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:06:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DDuQO0030329;
	Thu, 13 Aug 2026 14:06:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqbe0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:06:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DE6jQo32178714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 14:06:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0674058051;
	Thu, 13 Aug 2026 14:06:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4725805A;
	Thu, 13 Aug 2026 14:06:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 14:06:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 16:06:44 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/cpacf: Unpoison instruction results
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260807122132.3592583-1-iii@linux.ibm.com>
References: <20260807122132.3592583-1-iii@linux.ibm.com>
Message-ID: <6a2841287fe60bf310d302b6f4293329@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7dcf77 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tAftTHH-OHtipNmprlQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX8Piwj2Xzf8QS
 QYyVXg0/sCu/cbsO7FvjjXKYnypnVGSEcL4fOwN5GqEtjiIXH/XoS5EKHM5xYnz/Y8gTicRAY4W
 wBDTxaxNpFCznruWifXnVrOY5DPn2ci8IG24OVe8ffx9zqj4S0faOsWAu5YPhwXhUVOAqHXGZjD
 s8Vcq/WFQhW0MKdwiyaEmo1qeAHbi3T48ONDUHbRiOcRTPuofw1M80Y9XyKWJnTodSTN+1QTjN6
 ZBz2vnDgWwB5bWkJQJnIAn5tD+lmKE0z1yPCI99j6lWCexN37o2HwuGIEQFghmBA5d2PTawKCLm
 +CdirGQ3q3HBUGMl1vR8HWF+/W/6HRa8g/wo2UIwYz9cRYQcL89yopkY7yPw2qwBZNTCli6hf/g
 fSUi6ac2JrIueNnby7ii4sgA0hR32tVEvwM5ssFntrJFDlMeYtJaEFASqh+6myMQEwd9xGj04Xe
 5YOQ1og4ikkk+Lxcvzw==
X-Proofpoint-ORIG-GUID: pX3p3_7SpCURTiOzFpyDV49gVGg0auEt
X-Proofpoint-GUID: pX3p3_7SpCURTiOzFpyDV49gVGg0auEt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX/8Ltpt+jcZox
 YzZK14sxsLTMdZ1qqIgPqqHyCWb3Z6D2rxcw6QUM/kJXin07v9imFzlNQQOAtF+5MjPjbyE0u+e
 6ISe4BBcRhgU6lukvy7FVPzDq4zLj1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130100

On 2026-08-07 14:20, Ilya Leoshkevich wrote:
> Stop KMSAN from complaining about CPACF outputs being uninitialized.
> 
> Do not unpoison variable-length parameter blocks: mapping function
> codes (like CPACF_KIMD_SHA_256) to lengths is ugly. Let the callers
> handle this once need arises.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1:
> https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux.ibm.com/
> v1 -> v2: Unpoison outputs of more instructions (Sashiko).
> 

See my comment below.

>  arch/s390/include/asm/cpacf.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/s390/include/asm/cpacf.h 
> b/arch/s390/include/asm/cpacf.h
> index a83683169d98d..13d6a6344802a 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -301,6 +301,7 @@ static __always_inline void __cpacf_query(unsigned
> int opcode,
>  					  cpacf_mask_t *mask)
>  {
>  	__cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
> +	kmsan_unpoison_memory(mask, sizeof(*mask));
>  }
> 
>  static __always_inline int __cpacf_check_opcode(unsigned int opcode)
> @@ -370,6 +371,7 @@ static __always_inline int
> cpacf_query_func(unsigned int opcode,
>  static __always_inline void __cpacf_qai(unsigned int opcode, 
> cpacf_qai_t *qai)
>  {
>  	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
> +	kmsan_unpoison_memory(qai, sizeof(*qai));
>  }
> 
>  /**
> @@ -422,6 +424,7 @@ static inline int cpacf_km(unsigned long func, void 
> *param,
>  		  [opc] "i" (CPACF_KM)
>  		: "cc", "memory", "0", "1");
> 
> +	kmsan_unpoison_memory(dest, src_len - s.odd);
>  	return src_len - s.odd;
>  }
> 
> @@ -454,6 +457,7 @@ static inline int cpacf_kmc(unsigned long func, 
> void *param,
>  		  [opc] "i" (CPACF_KMC)
>  		: "cc", "memory", "0", "1");
> 
> +	kmsan_unpoison_memory(dest, src_len - s.odd);
>  	return src_len - s.odd;
>  }
> 
> @@ -587,6 +591,7 @@ static inline int cpacf_kmctr(unsigned long func,
> void *param, u8 *dest,
>  		  [opc] "i" (CPACF_KMCTR)
>  		: "cc", "memory", "0", "1");
> 
> +	kmsan_unpoison_memory(dest, src_len - s.odd);
>  	return src_len - s.odd;
>  }
> 
> @@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func,
> void *param,
>  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>  		  [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
>  		: "cc", "memory", "0", "1");
> +	kmsan_unpoison_memory(dest, dest_len);
>  }
> 
>  /**
> @@ -731,6 +737,7 @@ static inline void cpacf_kma(unsigned long func,
> void *param, u8 *dest,
>  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>  		  [opc] "i" (CPACF_KMA)
>  		: "cc", "memory", "0", "1");
> +	kmsan_unpoison_memory(dest, src_len);

I am unhappy with this kma thing. This would only work properly with
CC 0. But CC 1 and 2 are not handled properly. However, I had a closer
look onto the AR for kma and ... well this inline function should
handle CC 1 and CC 2 somehow and it should similar to the other inline
functions return the number of bytes processed like for example 
cpacf_km().
I'll open up a bugzilla to fix this kma inline function.
If you leave out this kma hunk you can add my R-b.

>  }
> 
>  #endif	/* _ASM_S390_CPACF_H */
