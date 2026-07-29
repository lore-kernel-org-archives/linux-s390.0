Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E847ACFE;
	Wed, 29 Jul 2026 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327067; cv=none; b=CxMgJhH31A6A+S6r6MzPib8gJtYdicmiJ0wHzfTrWkRiebBQt2JRN5fcIX6FyzEzyjBxN2IKAs8u/yLghaPmyt330F1bUwB1XpwJnU0bIsf/WU/16KkDkte83E3HIYhOQ3lCbjImvIJ7KsVUktYwI7XKasV0LKQTOUB3HMLKRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327067; c=relaxed/simple;
	bh=BCm8/8MPYDWZqyT9cRD3evXSapwf5QkiRopVps2IswE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX3vZpQUI7ubdckMB+eseS5dgcI5X/QBRbBiH3m1a3yyK4PElcCMo2yAvn1wkzKrNVHnm+9+lIMXflX/X2yOkmvo7SX/8/u4mFaGnll1xCxAxLfYYgXTTV995G20Fj51foC7BnHkz/UW10H/6UZs0M5iu4TOQdDlUPkujnSL2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rGgSVSMf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rGgSVSMf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHj8B4063626;
	Wed, 29 Jul 2026 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JANn/1kWaiit4JzMYr7rwF7KYZStGh
	PM9ZFBZ40V7kA=; b=rGgSVSMfw2p3LQoN3wShDuy/Lkrwg9/4fqE1fnasBzIDVW
	bbgn9buaSZt2+uyiCL3bj8ux5WxL1t58tmbF7cjwLFEUYcYw1EDeLGTRzEVpHSpQ
	Kdnk8lZYBgWE4QzASs6tGtnBhY3JHBqSlbmz0FMrOKv/VDpOFc8JFGa+6KbebpmA
	y0ZcAxd/aUDSG9oo9ImttA5AEuGY5RYC1RvSJKjw6/Yu+Q5vQofSrm+LG49G9OHu
	hk6nqf5wLj43BRnu36BkATQ6eVHJGk/iVLJQvtAkRBZ/90CQbg/wyLP/1rAv5E3p
	6XMlet7mwT9f7xtdoh9dOit5qJqz6TfxOLJ4CV9A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtj1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:10:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBuXvS004705;
	Wed, 29 Jul 2026 12:10:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw6q6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:10:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCAeVP51380640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:10:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0611020043;
	Wed, 29 Jul 2026 12:10:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5306B20040;
	Wed, 29 Jul 2026 12:10:39 +0000 (GMT)
Received: from osiris (unknown [9.111.35.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 12:10:39 +0000 (GMT)
Date: Wed, 29 Jul 2026 14:10:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/bpf: Add kCFI support
Message-ID: <20260729121038.61563B0b-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727140514.116501-6-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vdYLXFcGAPhI7mf8OoJmErwEAOBd-ZQ-
X-Proofpoint-ORIG-GUID: FT13Cf57YFQ1AUZ755YxBpVsfgqzXSlf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX4taZ+FZ9fkzB
 JtxgNFr2M5IENz0zM5+5VGEUJLKQcE1ZMW77Muk5CctYSBfXf25L/SWxofV09/ms3Qkrpnipcy8
 wCUgvSY+w95JX77UmY7SDQH5jGytybI=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69edc5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=naD7qE6c7dX3dS7GAa8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfXz53qNzmvaFXn
 tmy9x24lk42zvmUip7s5KCE1DSN6JveN2dbQRUVG+KJAPaKsTmWxPcY+lacHgbs+wW5BUzuGQgl
 +dcvyMJs26h7V9MHMlp3w5kpbLl8avSp3p/CRjKOUQ0EnU6ygcGygM0TzEAeyW8rvvDrityIxEl
 hyz+MsGFjNoIyEf6UYGpgPgBQpo2RT+iSJS+zw1EsOQInOxSCGXNROCY/zlTVQ2m96ymdEBVpS+
 mhWYmKPQH5KekMNlB+4prMR0EJ9DZybojXwsF6bU4RM3NWFJdyEm+pZAEtxzeUBwwzhvV89gWOw
 JcXgdyjrsgm7s5wE+p9DrdmGoH9w8ugko+Q53SuNynHYX7c0UHf+4mRjLjNyYodaqoAcvmNG2Z4
 Z/V1sBXImgrfBH9JiK6lnGT1FzDa0c8jNz6dx7fnjjD2Fxgv1VZ6ERXHqsOP5tqOxiBA4N/cV2T
 QQcF5/H0+NZidBiTvNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290097

On Mon, Jul 27, 2026 at 04:05:12PM +0200, Heiko Carstens wrote:
> This is the s390 variant of commit 710618c760c0 ("arm64/cfi,bpf: Support
> kCFI + BPF on arm64").
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/cfi.h  |  7 +++++++
>  arch/s390/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/include/asm/cfi.h

Question to BPF maintainers: do you have any objections if this goes
upstream via the s390 git tree?
