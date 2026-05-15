Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A4481659;
	Fri, 15 May 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845911; cv=none; b=SF8S0I+m4VK2YlLVDv2ClNnanwkCN+/CQ7jIo9Eg24XRtEtandpuVGsEU5GF4zEWZ38Ax8JZI7j5Rf0V1NMg0yZ3JTWEXaQYxMmoWaV63K44NaP9rvj64/PK/APPKmySBK6iJslvH/wDPccloFzPHyz7kUiWPpCZc+CJmAwN2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845911; c=relaxed/simple;
	bh=IA6oFuJ5AoXVALeoE3z81xeRiIabX4iRJZhmWDJOgao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI4UxMi7dGc8gniy1nJJAlRmIFrqfgQ8qUYQt5HIna0q/wiBvzJYmePCOIeCx75TDXjLjMDvgyC8hxnXGPDxclmwMtJFDK7tfNUgCX3PipqJlEcEAaweDPwqINsl67rpBsFiNXEmREnlZpkL3WtmoyeE3aY+WTRY4yyuxqanfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njNZLYDk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njNZLYDk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EJ6jZq4193819;
	Fri, 15 May 2026 11:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mpvwHfINL6xOH5ideGCzJ3vk44PHop
	VrE5MJMjqqR5g=; b=njNZLYDkwAetu7Dslrfq36i0uVhTIKc0iVhwp2rfM2WZGo
	9QbEP+EHMqKNqjPyzmjkyIfuL7Egp1rDsREZzZKz1Lj7q4ogcjS62Cq3P8nIYbW3
	YdPPbk3gIZ3BfQBAVDGyuvoDVhBvSE9im6Tz5Oj7TRGdPQFyOhpxiBt/fsI7AHAF
	xyzO30z3Rb0J2Sfih5IXxncu881uPBbx6DR69xUzZXJqco36jRpEOMQ/o8Pprifo
	R7XIr4vBcJmICC489wF9vLcmIIzDIAbbMbceZ6CZQolASFrUC4/Q5RrDv1LvPSBU
	jo2wMyU2yXPpmhewjdCVaXs+LvxZV9HOjqb7weCA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8y2w4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 11:51:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FBd5Um009796;
	Fri, 15 May 2026 11:51:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvckb03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 11:51:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FBpjo840042968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 11:51:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DBD20043;
	Fri, 15 May 2026 11:51:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54B6520040;
	Fri, 15 May 2026 11:51:44 +0000 (GMT)
Received: from osiris (unknown [9.111.88.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 May 2026 11:51:44 +0000 (GMT)
Date: Fri, 15 May 2026 13:51:42 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v2 5/5] KVM: s390: Properly reset zero bit in PGSTE
Message-ID: <20260515115142.70445-E-seiden@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-6-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512175251.300882-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B6NsyhI4p6wytRHiUb1erfj1FUANlBxq
X-Authority-Analysis: v=2.4 cv=RemgzVtv c=1 sm=1 tr=0 ts=6a0708d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=9DvXnxvuG7zSzAFeCowA:9 a=CjuIK1q_8ugA:10 a=UzISIztuOb4A:10
 a=VxAk22fqlfwA:10
X-Proofpoint-ORIG-GUID: B6NsyhI4p6wytRHiUb1erfj1FUANlBxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNyBTYWx0ZWRfX8a0TRFT5URfi
 c51sOHU3ts9qNfLCHyR1gK083oYTKBVZECGZxsjX07tWFqP40pNByfB5t2vpbO2uBFVednz9sb9
 8L9PFIi3x/HBA5s9DLTnqATAl05W2jJ0wOHK52poWTDu/rpUXB8q/g2pE9lADITV8cTwEkKzbeB
 HFriSoPzMOxmF8ypeP9eGFK51rM2DvAbCCe7lvkTZkB5HS9ChOmuTvercFK2zkawm5zeoiKFp97
 IdWEl5BTZ7qUVsJ9YdcS3B75cl24LlfUaOTvXIYSWlVDvc1j3+Mn5OAEOu10LrjUwtC8vhfbJU7
 mimyfVxwavT+d7cCNDG37O/cfRknn4A8fxphapRicPN/uUzix6emqBHzn74kgLdbB4Y8XrfgS26
 j8oiU8QDU4o9HHIst09DM2agMi49w2OgkvFpxk+SWnPDUl49FwOxcxYkwvop/3Z4sKpzsd7xyEs
 /mFbvMao674IrprA76Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150117

On Tue, May 12, 2026 at 07:52:51PM +0200, Claudio Imbrenda wrote:
> When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
> prevents the page from being accidentally discarded when getting
> unmapped.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

