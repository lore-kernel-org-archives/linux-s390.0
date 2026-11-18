Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996816;
	b=ExiBkH3fUoTH5untpxDLeEUrRelueF1HtzAAq6EgRpPSu5fpSvuBdLCuQMrcja1J/f3Q
	 X7ckrncck6RYagXUY11Vf1rwZiuZX45TAESZKqV8vm9ToSBEY4n9/DsDMuencR0qkxkFf
	 6O/DJg0jm42vumpcHa4bq/9l+5p0KU1LBVGzXNsO1hU5latOTmOBwu8A69PiwfTEEowLE
	 Y3nWjZXChXmPglTMvC0TTtaa29B8Q9gGY3HAM1EMgh7r/rQu6RoAzUiIqMy70z1bWfaHq
	 xpyGtSlivGBbydRrYequR5g2zw3IMOF+M4pf2DLnu5pLeAa5TOiMjg75Tcpb9MFCNvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=C/4PfCzvD/ktb55WsjcO5Qq4YUlKt4F70+506gstecI=;
	b=PYoHIjtR5oEvykOCeKNe9aeXHMZnp9st4MF0j46o/YCZtt2AVNqCBsaRlQYNlGy0DJl+
	 azB6tMZ020j5Hu+ksmC1b0JfkGZoJP59LyxDnsmSEbwsBlnVUTSAHvJNCyiRF+FgqFJbE
	 twABlWpSedlsZfnFu5aEodAmcjyyetDZzILSSULZL+obnQ1wk7HIwseeovSYq1nC6eFCJ
	 SHlvQctYVyvaM8vsqS2wKOKjz7+MaQdtxnbXIf4f45D14u+bhTx+m8RqC0CdRihjw43/e
	 8DCOM/JDKoSrIqOTWGh+uG6TbHus8xlIbF8gl6rTaBvA5nYrRV24bDmBHg5X/MP7d7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VzMlTItv;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A9606A338;
	Wed, 18 Nov 2026 10:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585A9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VzMlTItv
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9uObJ775952;
	Wed, 18 Nov 2026 10:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=C/4PfCzvD/ktb55WsjcO5Qq4YUlKt4
	F70+506gstecI=; b=VzMlTItvEZDdJdIKnjKrOoL+rPB9z1k1SZNOJQLoFvNrN9
	YiDRFngNmnB0bxyB6kfcfrbk9jfU5S3Hyu1/72z4nDg0Ab7nJMTn2wcu932UWIam
	7LicjuL4YiqmajZxbPePrFEsv7jCCuROkZSnPVuOYNw6fbrHj93Eqpxzseo0fCme
	bIaiqJ0ITd9BhJIgr73q1KprjMUl2xhBAJxHiTjJGHCVzz2xy/Mu8DBceEkoe39e
	xpwwh0eC3uLttB8K90diByOWV9oUAFj3GSBXGVhjhRgNIEJxORZ5jwRxgmFn0WFJ
	ljdYQcP6XKWvfWdP6mGb6ea9PNxJOf4V7jGdurTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsv5e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:13:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9oWHn2938469;
	Wed, 18 Nov 2026 10:13:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jufrup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:13:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIADQvh35782928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 10:13:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984222005A;
	Wed, 18 Nov 2026 10:13:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B9C20063;
	Wed, 18 Nov 2026 10:13:25 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Nov 2026 10:13:25 +0000 (GMT)
Date: Wed, 18 Nov 2026 11:13:23 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        linux-s390@vger.kernel.org, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: add CFI directives for call_on_stack
Message-ID: <20261118101323.14542B45-hca@linux.ibm.com>
References: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
 <87qzgkpsby.fsf@oracle.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzgkpsby.fsf@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GA23wieAIJscNyKWE6387hABDrpOWVLZ
X-Proofpoint-GUID: GA23wieAIJscNyKWE6387hABDrpOWVLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX3xU3VRPKfUxJ
 u/LQLYYizHiftU+jYUWkaOW6o3z4eqBXMpb7seg+Wjvu95CrvqT4bWQcygf6zqDAe4iMX3LHEX0
 c1e+TWfTElsWLuVsX08UfW8hWD59h9QmLCUq+Bro8mw9fL1n3tbv5Dm01vwGSWbzfX+suX7xL/7
 YMoC+O3NbJfskz9mP67am75tVyHuOBtDP5AycXHz25UVZa9fnRKqH8iwbmzZc6IcMdNp8jSMkL4
 QyjCt4Qz5H3ZeXZHnJt4fUUo7Kk09OBupv2QASdCw7O5Z0DRT97kJTpJWiuduRFZ7Dr5Rx83GL/
 TKwcpYyGv6s4Awz0Vs+0Roww7CryrR/3/7cUFbaPJmluyFxz6P8bHTq9sdGywkqvt52VcanhO16
 a/2lmiHZT7IHbAoh/vukE/82gOFTrpVvcIjPfA/SzsOGkMiDXB8eFomJ3u6e++2AomYAWXYyEXD
 IgCK3wfO4YSxTk64nPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX3ZZcQuCviIzn
 +Hkwx8w1w+S5qgMWU9kzJqbpBj6ibOnNzIYxLKnk0WiN3wc3PilA46oWXaKo1ZkJUpiOSa2OSEV
 zjsTBdtkxKIcal0xnSTVBBPnfQn8oVs=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd7a4d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=17FYL03jAAAA:20
 a=yPCof4ZbAAAA:8 a=NHV7Ha0uC3VOG44dLV0A:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180039

Hi Stephen,

On Mon, Nov 16, 2026 at 10:02:57AM -0800, Stephen Brennan wrote:
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > When debugging s390 on drgn, we experience two issues. First, when a
> > panic is triggered on CPU 0, drgn is unable to unwind past a stack
> > switching event[1,2]. Second, drgn is unable to unwind through an
> > interrupt exception frame.
> >
> > It turns out that the reason for both is the generated call_on_stack()
> > assembly. It modifies %r15 (the stack pointer) without any CFI
> > directives describing this change. Thus, the compiler-generated CFI is
> > wrong, and drgn tries to unwind using rules based on the wrong SP value.
> >
> > To resolve this, use %r10 (a callee-saved register) to store the CFA in
> > a temporary register. Then, emit a CFI directive describing the change.
> > So long as DWARF CFI is used to unwind all leaf functions, the value of
> > %r10 should be recoverable, and unwinders will be able to use it to
> > determine the CFA and continue to the new stack.
> >
> > I've tested this only in a QEMU VM using drgn's vmtest framework.
> > With the patch, drgn is able to unwind through two stack changes: the
> > change to the IRQ stack, and the change to the CPU0 nodat_stack during a
> > panic on CPU 0.
> >
> > [1]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/vmtest/enter_kdump.py#L69-L74
> > [2]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/tests/linux_kernel/vmcore/test_vmcore.py#L19-L25
> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> Hello,
> 
> Following up on this patch. Is there any additional verification I can
> work on to help facilitate review?

Sorry for the late reply and thanks for providing the fix!

Please be a bit more patient, your patch was not forgotten, and
nothing needs to be done on your side. Might take another couple
of days before I get to it.
