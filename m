Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85A37BE6A;
	Thu, 21 May 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380857; cv=none; b=i0QbXIfWx8CcsSruV7uFPyY2pZk7pyjawsJQpIsPuQBXxJCEGJmJ8sMDxpaDW9kZhG3wnI1dP1LAqZc+IKubCmMrRRRWjzCpEEzVBJdXZx96PXDd3o3rS80Sh4wffuCqS7XuEhpw+zC/kpzbfKZICVcSDwS68foEviWjkqKCMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380857; c=relaxed/simple;
	bh=3TUtRpfhSrXeGSg3aKW/Ckk9B5+9KTJVdWvm8HL5qNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxF25Z4iErpqbl+mAzfYIfwFjWFcT3Vl6R7o1vazERwpjFx+RbigLdkYjDSbQVaE8pebgHyPgFIY6QoyZp/eW+clRWmFrJWtjCxuisYt6GblUFLWHvYen88oAM5QxtBRCV8zmRQtbCzcQA9dK3Jdo1jdhiHz1vxt8Pw1r9U12KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a1W4QABK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a1W4QABK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LEZj503252227;
	Thu, 21 May 2026 16:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=m1y20CPnzJ3zSfFfVqLs4Yj/EMuxMI
	uKfzjStw/FMyM=; b=a1W4QABKAwe4e+p/1X9KDUlmtJD5k288Ett/MMq3ikZo1N
	6ml8xhspQm7OoJnOZdjP4MgVcSkRmAIvdBj6Sy/6rn932YosxCTiXXy8VJe5eOIi
	mGeJ/7mAbWp2K3uLg4BHg/VjQM4bkPzK2+QetE/7kgG5SBkuoEe6F/5FvrAPkP2D
	+wnXad4L0m3KM/3Ngko1rNogdHU9FS7/mOPdliuBMagvSgFL+7vkkuD3kzsHrw1X
	6mEEGITlx/tx/rShtMM0ejSDUtdL/jLGPWPETWK67QAIFmmiCplHwDAlYXa4RiCM
	mWb/2wm9XIt3yCo7Z2KR8qi8Fg9goxQ486xE/Jmg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawevkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:27:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGO4XI013304;
	Thu, 21 May 2026 16:27:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhw30v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:27:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LGREEA13697328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 16:27:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151CD20049;
	Thu, 21 May 2026 16:27:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B3E20040;
	Thu, 21 May 2026 16:27:12 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.26.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 16:27:12 +0000 (GMT)
Date: Thu, 21 May 2026 18:27:11 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] s390: enable Rust support
Message-ID: <ag8yX7om86S--2Ws@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260519151215.1611802-1-japo@linux.ibm.com>
 <20260519151215.1611802-5-japo@linux.ibm.com>
 <DIMRQ2FA569H.3V1LI6U897MPU@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIMRQ2FA569H.3V1LI6U897MPU@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2MiBTYWx0ZWRfX6lQA+G7y6vos
 iC8VeR0QH8GZC5910b9dVwhLmTcs7P1pBKWNG/4RighQJlBKkQdRH3P1pwhq1IibxikEzpYFyjo
 D7JpKbObR1VitHDJDOq5CzdyJcwEjN7F1jQm8fgq+1bEgWenPS+BU3+n2Z2S0qoKx0SXE5dswKj
 lkoYWJtWqiNnEz4hEn4dv9B5zge0HVBmbKbL+VErzxDqFNT8Xln2OBBySHMoAGPi2u984zeM0P+
 wxCRLR7nW8uPPfkAocqUPBmbv+9Q2SXnCe3LLU3KE+swyuh/uZQB3DGnKmpXTQmBjt9vaVkL107
 MSNLkxcPxeNGY/6YSvYvLxfOO7OxbZteEysLf46EISvpmynE0F3rl5S8spvEScRA/MgTxlxCo6r
 bs44j2LyQWxnU3diyPqEofDL+KMQJoXHoscrlc2MN/hRWoIFnk2U56w8CFmnGr48VqeosxtC8Le
 7czMK4hxUjic7+0DmaQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f3267 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1MSMDuK9x8fRzs5uTu8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: AJ_0GxZDkpH__6FWpoHmo8H24KBn62j2
X-Proofpoint-GUID: Isk4UQecj4L_u9DkcUU0BGGPeJb28JlT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210162

On Tue, May 19, 2026 at 04:45:33PM +0100, Gary Guo wrote:
> On Tue May 19, 2026 at 4:12 PM BST, Jan Polensky wrote:
> > Enable building Rust code on s390 by wiring the architecture into the
[snip]
> Why not just
>
>     mflags := -march=$(march-name-y)
>
> ?
>
> Best,
> Gary
Thanks Gary,

noted and updated accordingly.

Best regards,
Jan
>
> >
> > -aflags-y += $(mflags-y)
> > -cflags-y += $(mflags-y)
[snip]
