Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E403126D6;
	Wed,  2 Sep 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335464; cv=none; b=se63qf6Xj7A8RBYJ1TBRt4x8Y2xR8cJuR/5JLuHeefoVBq7htHaQmp3J+svn6vlVmH+vXxunT49TMLQ/7XAYhNZIbXzmANnUTWUB/n0hMokct1RX2fGOxin+xnGq8zodLoUPHpYZL35GRY8IV7YzxJpl7x7XAz3GcUkfBm2Mu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335464; c=relaxed/simple;
	bh=W6hRqxZBEOgpv20ek4NphfTQsMX9rBqDsGLYOSIwzSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGm3ApwGzxnuinapccEOow4XykWlXU1BtUGL7MUjEvshWFOguab7ZdSH/LIQSWZfEOnUAwm33X0QVzT/+lVF1W6Vcwp0wZiBzPa+PMJ8CcfjKUJUY8hYNK+m8ZU2uaWyc+o9wa0anbhJm3wmINYzfuiBVarPFfMee1Pfed+hzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cxVuV2uv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cxVuV2uv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VoWJ2306841;
	Wed, 2 Sep 2026 07:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9ejSeD4KjKKws421Wn1Lo2KRjTk+Zu
	TAlSMpzMTTn2w=; b=cxVuV2uvzkgvcs5EuoRdkgcUKRWAr5Xjwo1jC1fhMJKbAj
	Be6LQnHyTobrmD0E8UrkCTLJf8OGTU+R54sENjr1innuQgZxieP0rxW86GNzw1hS
	+dP9P/t65Ka5SytaXAXHEcLcHlEl17fNJGrw3qExpWhKK14HRgSjXuAZN+OSENrF
	0ixZuJHHgBcEblO6aB63DTukueTSLI9hUZ5OSoTVkRjaO7D7Af/zK9DaUPsvZBdl
	GS/uoaGz+TZPRP3CyKlD+ftiQdrHXJRTklWrkQll58YzmlktsM/rQqRYynQ0AhWW
	ikkrJX57JOTPRF5YGjEmBmVLzuAEH0lTN5ebipgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudvtex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 07:50:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6827fNxk006691;
	Wed, 2 Sep 2026 07:50:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygg9gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 07:50:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6827oUxL37814712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 07:50:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632CF20040;
	Wed,  2 Sep 2026 07:50:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F30C02004E;
	Wed,  2 Sep 2026 07:50:29 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Sep 2026 07:50:29 +0000 (GMT)
Date: Wed, 2 Sep 2026 09:50:28 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
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
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
Message-ID: <20260902075028.231001-D-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdweRfqt4dTxcU9@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QF-vG4BX5O9Aa6yStpepOuZKOE1eMyna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX1WgqhhycMSVK
 s9TTuZZWkFfejSZv8rcgEHtbfySdP1FbI2p6sJ8lf5UVjmD8xtSeQqaeDIqhpm9AVi+eqreLCNK
 4NketVL6IBOqKHZVZK7uoJ/i/fUxsq9WruPKIFlD9cV5ZERHZlK8U9zG+koiOWfJThl/IhB+nbT
 /Rc0IBpB4uNoE84/ri3yNtDGCRrFRohts+Pg1taTifUVd3caqvrjDY2YmpHY7bkC3h63yqWIUb/
 HkzhLaJ2/cHPbe2q8fwvqi3DEGaLvPCNfOOxj486T6+LjcmcAorE11Azhw4V/UpSbbGjSEcgC3M
 TRN/62A6OrgQFJO03bzM9GTPBwVh44lYo7lv3Hq8a3AktmUl5JK798ONiVDo5kGzyaPDGmaI22Q
 q81Lcz+GoV6EfyB/m554pLNSJRJ7W7ya8LvwPZSUejGoMdeJMiQvPt4+5MfiKHst15fPHlIrrZy
 YK+63sLTYofdlCVPePw==
X-Proofpoint-ORIG-GUID: fANCLW2A9Trn8myBhZjBZVyvyTFzAB3n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX33hdZLrCOFfK
 OQQ8toNI0ozMn9YS4Mm21FSWxILdLLBVkjZ4MI6+sOMJ0hLlup1Gs4BYycC/uA3Vpv8med2wOms
 WjXkSL8iPba98ZH72g14RM4AVVTRDBk=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a97d54c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=_EcWKeZr55_4eD5WYHIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020066

On Tue, Sep 01, 2026 at 05:40:25PM -0700, Sean Christopherson wrote:
> On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > Allow KVM implementations to choose alternative device names. This is
> > especially useful for architectures providing multiple KVM
> > implementations simultaneously. Architectures providing multiple KVM
> > implementations must compile the KVM common code once per
> > implementation and mange symbols.
> 
> What about tracepoints?  Or do those show up as "kvm" and "kvm-arm64"?

Yes, I want them to show up as kvm and  kvm-arm64.

Thanks for pointing that out - I just noticed that I forgot to switch
the trace system to kvm-arm64 for the common tracepoints in
trace/events/kvm.h
I only did it for the arch-local traces in PATCH 21.

I would just do the following:

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index b282e3a86769..5d4f8a0693a3 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -5,7 +5,11 @@
 #include <linux/tracepoint.h>

 #undef TRACE_SYSTEM
+#ifdef KVM_S390_ARM64
+#define TRACE_SYSTEM kvm-arm64
+#else
 #define TRACE_SYSTEM kvm
+#endif /* KVM_S390_ARM64 */

 #define ERSN(x) { KVM_EXIT_##x, "KVM_EXIT_" #x }


This would leak a bit of arm on s390 into common KVM but I do not see
another way.

KVM_S390_ARM64 is defined for all arm-on-s390 compile units.

I think I'll add this in PATCH 14? of this series or create a separate
PATCH.

Does this make sense?

	Steffen

