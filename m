Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B11AD4B2;
	Thu, 20 Jun 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891984; cv=none; b=jTZ6U2nLdtOsjalJQo5/6GFmiePnIT4vKiq86zRwjaZDRuzT9L8VA/qMdJZR709ro7p9CToITEcEbtpNWJcs568YYLxQry+R3DGzq5iZXPyT32kaS5e4VxdK3eTSFY+YmeU8iKyJLpVKZ7fT1TW4YAAHlKm3mwBc25sMMBAVc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891984; c=relaxed/simple;
	bh=+Lcvtd6El2bBqQL+WL4mFMdWQ1gU+MSb0PuigTxLO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bArXhLuJ6a9LW6uPEW+b3JUSaYFo1evd/GZEyx56PsxleyIE05ohACWJhQCNCmnw1FJkQN0KanZR+CXba1CnGqUIURw1OkE6G6k3LShsotX4KLl5FSW1f5DtNV9BG9PnVt43Jk2UIdX1Tn8AzQPh98jDt3IVoOIP/NtrSoFE6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XOKXz9J4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XOKXz9J4"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KCcxjq025693;
	Thu, 20 Jun 2024 13:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Sx+HfB3BR2YRmT+xxLQT+3Kz6S8
	G9rp0ct4rpiaXuzk=; b=XOKXz9J4rIm/yG/9AKZGuYV6IdyPRyM/exfwrHPxYXI
	VxjahveyQKZB9wG1VAQxQNNu2bL/AURKfrzL3hJeJVLKaK7KZZFiS1vZoUFohbB8
	qCjBhf4+s/e4fTkOywoorMh5Jv85ZrpOTAnsB/vZF2S2HWwQwgT62yKB/btufhHt
	Og9FG3UpUyPUu7LKZ8AByti/Bz1gg+E4x3eSgD7Rx4brcR/wD4xbWEQzM+OnMHGH
	IJ6eHnZ3XdmLP62WjQUX3Ye+hSJEe8xrvqbJS1Kounmwjpt6NnQFnq5qjhkiDC4t
	WcVqVpxvQ99He+KetAOcHQH5Uude19XFB9feagsRgjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvmfcr8eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:59:13 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45KDxCiQ030476;
	Thu, 20 Jun 2024 13:59:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvmfcr8ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:59:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KD1dpH009433;
	Thu, 20 Jun 2024 13:59:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn6b1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:59:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KDx5b110355036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:59:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FDA2004F;
	Thu, 20 Jun 2024 13:59:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A2632004E;
	Thu, 20 Jun 2024 13:59:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Jun 2024 13:59:05 +0000 (GMT)
Date: Thu, 20 Jun 2024 15:59:04 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the architecture-specific
 functions
Message-ID: <ZnQ1qPGClXw/rB4o@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
 <20240619154530.163232-37-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619154530.163232-37-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0sr2wn6JJ7mPm7i81bBoB7ypHtTLDaoS
X-Proofpoint-ORIG-GUID: mWcN6U0d707TXYiv4F0Sp_RI3phaZYEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=407
 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200099

On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:
> arch_kmsan_get_meta_or_null() finds the lowcore shadow by querying the
> prefix and calling kmsan_get_metadata() again.
> 
> kmsan_virt_addr_valid() delegates to virt_addr_valid().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/kmsan.h | 59 +++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 arch/s390/include/asm/kmsan.h


Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
