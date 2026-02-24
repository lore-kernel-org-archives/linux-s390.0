Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6011E5207
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901321; cv=none; b=kG2M7Aw9LD5JTwsi/amnktwqfDIDXq5c0Ibv7jkfIpzTWbPqlQxors9zVEUVpJzDVaFpVj6GOisAxMi9qAVkNntA3ZiMprFW/96MmI/5XYJEWhREf9YjsBnt+HAbVvWheSr2cyU+SB+rHwLriSJNx2xcr76EaQ5J6qJQkJfVKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901321; c=relaxed/simple;
	bh=l2tMNMzjGRM45hi8vqVUr7/B4Ha7LTCYRHfoITfie48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uptdI13FwNE0PyW9aJXTo+CmAqOE3WgqWRWOX7VC85nzuWBnrSXtRCEwWG0O5YSv9tYh+BfKzyMsBWhiVsk717Iissw72M/cdPBFm19c/M7/tNZlqY4m4cqDJ9iuZ8UeoZoXLqaugChY2on/cs/VgIcFfuTEUhYyrWwYdtPhKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FemXi7ss; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FemXi7ss"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771901317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIKwRka9uRx6XIueiWEg8ITzTExx3IPh0tjc5q1LfnM=;
	b=FemXi7ssAYINqqvUhH0OISJsGDIcXxPyqATNY9scriJavCYHMYizU/9fvtnZE+x3sVrRQb
	00uit8s2/8BSs6qEOER2kxSRrwP9FB/7/v9bgJmb8UPt6a33w83AMSLO250TB8nCHFd9Ni
	tB8nUONyLIR1CPQyn84dEfFAdeEXeUk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 bpf@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next 1/3] bpf,s390: introduce emit_store_stack_imm64() for
 trampoline
Date: Tue, 24 Feb 2026 10:48:12 +0800
Message-ID: <23014019.EfDdHjke4D@7940hx>
In-Reply-To: <9a939e13-d462-48e8-bc4e-19157b353b4c@linux.ibm.com>
References:
 <20260223084022.653186-1-dongml2@chinatelecom.cn>
 <20260223084022.653186-2-dongml2@chinatelecom.cn>
 <9a939e13-d462-48e8-bc4e-19157b353b4c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/23 19:44 Ilya Leoshkevich <iii@linux.ibm.com> write:
> 
> On 2/23/26 09:40, Menglong Dong wrote:
> > Introduce a helper to store 64-bit immediate on the trampoline stack with
> > a help of a register.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >   arch/s390/net/bpf_jit_comp.c | 27 +++++++++++----------------
> >   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> [...]
> 
> > @@ -2743,18 +2747,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >   	 * arg_cnt = m->nr_args;
> >   	 */
> >   
> > -	if (flags & BPF_TRAMP_F_IP_ARG) {
> > -		/* %r0 = func_addr */
> > -		load_imm64(jit, REG_0, (u64)func_addr);
> > -		/* stg %r0,ip_off(%r15) */
> > -		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
> > -			      tjit->ip_off);
> > -	}
> > -	/* lghi %r0,nr_bpf_args */
> > -	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
> 
> LGHI is more space-efficient than load_imm64(), can we keep it open-coded?

OK, I can keep this lghi instruction as it was.

Thanks for your reviewing :)

> 
> With this changed:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> 
> 




