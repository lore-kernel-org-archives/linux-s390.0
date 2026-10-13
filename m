Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A84F30E3;
	Tue, 13 Oct 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894059; cv=none; b=EW+pLzi5S/e3FQVMKvT/M9U/ew+hWYfeC2/8OGdRpRLKg3UEQUOZiI2ttZFduxbHk+VuTLkF+x3LT8ia5TUxi+/6/+1Ll/fhVsKJLM135IPr+/ymNk1bn4yZfiy+kPM1064KTEzPUODRL9vaKiIfufSPDa2GX1LrVZcPzMeSQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894059; c=relaxed/simple;
	bh=bL1tItq7ZdylF/YF61l09KyqgS4+2/pv8qmjYfPYwHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgOEnIDzqtX7oRYvHR0djUNsrjWHMnO2HHuB6X6qBpNZrygvquVYhV6YGkYg4bioGYURzHzXl2GkcBiuz7310APK0b8Uo0GLbnzTumAj8hgGl74Veu8q7FD187ROFbR7TXqLtwV0sNesTJoBNw1B2sma5hf/8bnHlGY3J86mRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxTJtwzm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxTJtwzm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EQYo725918;
	Tue, 13 Oct 2026 12:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MRUalqRtRvSntq9qHBpBhUB1PKZVXL
	F3flPOsZ+RInc=; b=pxTJtwzm5uW6T/tlzmALwrNe2RFq09l+5gNVJr+ziCGjHJ
	pomA32nrq8a2kgeuG3a+5xiw1y8EP3P/ejlFv8rmL+Aa5LPJY4C5mQT3UAaXWTrs
	l93DFJNqBDEfgDPmIjY+mdlVPp6Rw1r+0SaJ3LUSkx/JjpC2alBd14LktXVS2N46
	g4hoLNRiopZYkGM2rfYzhx9xhvG7kKexI/4NZfvdzOy9becAUnarSDAwA1j958up
	OLEaYjUAcNnbqSpYmJuDnX5rb+3BWNmqLzS8yCrgjGEc6sFjD9EXwrdcDxrhGmIf
	6qS0N5/LC4hbHafYm7SvolC56D3hm8PzfW8s0rLw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0dh98-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:20:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8TmFR2709266;
	Tue, 13 Oct 2026 12:20:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h1nmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:20:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DCKLuF41353546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 12:20:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A2A2004B;
	Tue, 13 Oct 2026 12:20:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FC9B2005A;
	Tue, 13 Oct 2026 12:20:21 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 12:20:21 +0000 (GMT)
Date: Tue, 13 Oct 2026 14:20:20 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v10 02/24] KVM: Move architecture capability Kconfigs to
 header defines
Message-ID: <20261013122020.715112-B-seiden@linux.ibm.com>
References: <20260930173441.66762-3-seiden@linux.ibm.com>
 <20261013121343.1997112-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013121343.1997112-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfXw1vuBnBY6H4q
 yDFRp+NyHn9kuEOrrNM7gvFzE2Drn0AaSHOrlVEAPJEs0PQ83Ecr/x1xw/YVf/lq1KTKJF2+Tg6
 QJJYePqW85kipHG+BVaexzyTs8rKWfc/s91sx8OTkjEoULZbJIv0Z66xstHJOCeH+eFCvP3HCIC
 DPmDq2hvjqOjcXIc7lJ8ZLT1fCV1/iRSnW8B/Hq/S4LJHYHs5XJy3AnCnSkJ/8zt9THbnbCB0N3
 w8TLnO3+rFrxTFRERB2+NLLH+ZNLj0L9hMvZvLXxrSPtllVbU1ZCCqi6zK8dl1E6YgcskRaBxcm
 kjJo+T9+vaof+OjqhC6Pm/emfoc9ui9/ci0XQehu2fm5+itYMoo84BfzCDZXJwA/DicFmM76GOj
 6NZ+WPmf8Pv8U+aZ93xnlw5ai/cu55nR4PaubmSD85ZGrRrhXmN4lHtxG/3A1Emy84TOKQnAfNr
 09KRPeNAsBoJGTYHKJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX3Ul/ZRBSoJYn
 YdjpQuIQJ6AtxtHQkf9GGOVDSAWjViKkjQBuVH3R76cdrhsh2qV+4+1yrR/dzByuEIxIcQinpW7
 U/POH7rtSIATqir57jNNGOkvYEHINlI=
X-Proofpoint-ORIG-GUID: SKFKHnac4L8MYPRuplyNRWhE2cIjCrq1
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace220d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NdARYpLW5UMHRz0coIMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EjGZ8dcDGMEWgiub1te0ePOOY7FqYobL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130048

On Tue, Oct 13, 2026 at 02:13:43PM +0200, Steffen Eiden wrote:
> With s390 hosting multiple independent KVM implementations within the
> same kernel build (native s390 KVM and arm64 on s390), global Kconfig
> selections force both implementations to inherit options that only apply
> to one of them.
> 
> Replace global Kconfig options which only apply to one KVM
> implementation with architecture-specific opt-in defines in the
> respective <asm/kvm_host.h>. Only remove Kconfig symbols that would be
> different on both s390 KVM implementations
> 
>   - __KVM_HAVE_INVALID_WAKEUPS		(formerly HAVE_KVM_INVALID_WAKEUPS)
>   - __KVM_HAVE_MSI			(formerly HAVE_KVM_MSI)
>   - __KVM_HAVE_NO_POLL			(formerly HAVE_KVM_NO_POLL)
>   - __KVM_HAVE_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
>   - __KVM_HAVE_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)
> 
> This allows each architecture and guest implementation to configure its
> supported capabilities independently in its kvm_host header and eliminates
> adding unnecessary fallback stubs across different KVM targets.
> 
> Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
> 
> Sending this patch alone. All others are OK or already picked.
> 
> Changes for v10:
>   - Use __KVM_HAVE_ as prefix
>   - Clarify that this patch touches only selected Kconfig options and
>     not all.

Paolo, 

Sorry, I somehow managed to not CC you, doing that now.

FWIW:
Original patch v10:
https://lore.kernel.org/all/20261013121343.1997112-1-seiden@linux.ibm.com/

	Steffen
