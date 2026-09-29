Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C5296BCF;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662830; cv=none; b=g0dR+5MNE+Sbp9Em6pl2gAmthOkftZsl8pvTaU3Pwb7W/3ViBfwZIWTuYfociCRKU6UEx6DkBzP+vtHGdCj2Edxzf7M/O+djrf4yH7Migv2BIoWZXSw/3Q9+ZpQCaob3iA993cXBIZAGutXfFrl8ca0Wabj3XlpCxWiVme4VYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662830; c=relaxed/simple;
	bh=nBq0ce4U8pjNwOIB6srOmZAAPAVFm/4GWAgw9e8Y3ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQqt3FU44wfZsLETUCNUSlsk0u9t8sAkkZyz9Qaqr36kqb2KsWX5Ow0dlUWtsOugDyb24xrPJ5z+xGNQ//UbY+wk8ESLO+lYTU/Jhr1/eQcIwPWFXcHWqbOtw1z3/PzaAHS/gahp701tc1rnVIDYaMD/vJoJUyiGYAXqPch15mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEu8IKuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEu8IKuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE9C1F00893;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662829;
	bh=lTp0iuvGgJlzLvCthN8H5DikguIjM02dg6D/PwjsUlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FEu8IKuJTM9UMyqWZRahuIUiQ6ZhkU4IDa2UZdQ+AHlfxY177GM88K5j47ZpxQMhi
	 9FiOENuKjoLTRooDK6SGMn2gMDlmCoehRnP5Cw/6TyFOVTgHclMnxY1UKAjDkiTEI6
	 K/Sd5XrAq9hpy03DSh95TZmK/hIC7jyt/XZ/GJsm1/KicRH8pbBdQeoXB2Cik/5FrY
	 LhMT7P074WF9asToy5KM2I1lRfV//rJ6lF3tB8DG7vCsCS3rFqo0lGgSOlqUmWzNHX
	 s6HPW0a40ZjDMKNQPLiD/ZEq0vCO79vhQpa0nH73XgM4QaTO4I76tb4UQji83RPvZR
	 pHebvU6K9zPcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A59239253E9;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/3] bpf: Fix use-after-free of progs detached from
 busy trampolines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179066282803.293113.8557815551946775052.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 06:20:28 +0000
References: <20260926135605.1217928-1-florent.revest@linux.dev>
In-Reply-To: <20260926135605.1217928-1-florent.revest@linux.dev>
To: Florent Revest <florent.revest@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 kpsingh@kernel.org, john.fastabend@gmail.com, leon.hwang@linux.dev,
 zirajs7@gmail.com, rhkrqnwk98@gmail.com, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, hbathini@linux.ibm.com,
 chleroy@kernel.org, naveen@kernel.org, bjorn@kernel.org, pulehui@huawei.com,
 yangtiezhu@loongson.cn, hengqi.chen@gmail.com, linux-kernel@vger.kernel.org,
 aou@eecs.berkeley.edu, agordeev@linux.ibm.com, alex@ghiti.fr, bp@alien8.de,
 catalin.marinas@arm.com, borntraeger@linux.ibm.com,
 dave.hansen@linux.intel.com, emil@etsalapatis.com, hca@linux.ibm.com,
 hpa@zytor.com, chenhuacai@kernel.org, ihor.solodrai@linux.dev,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev, maddy@linux.ibm.com, mark.rutland@arm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
 paulmck@kernel.org, pjw@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, shuah@kernel.org, svens@linux.ibm.com,
 tglx@kernel.org, gor@linux.ibm.com, kernel@xen0n.name, will@kernel.org,
 x86@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 26 Sep 2026 13:55:57 +0000 you wrote:
> A task running in a trampoline image can call a prog that was detached
> and freed in the meantime, when it slept in a sleepable prog before
> reaching the detached one or was preempted right before calling it.
> Patch 1 handles the preempted case with an RCU tasks grace period,
> patch 2 handles the sleeping case by patching detached progs out of the
> images that still call them and patch 3 adds a selftest for the sleeping
> case.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/3] bpf: Wait for an RCU tasks grace period before freeing trampoline progs
    https://git.kernel.org/bpf/bpf/c/0fb5751a6e41
  - [bpf,v5,2/3] bpf: Skip detached progs in trampoline images that are still in use
    https://git.kernel.org/bpf/bpf/c/17637e1a581a
  - [bpf,v5,3/3] selftests/bpf: Detach a trampoline prog while a task sleeps before it
    https://git.kernel.org/bpf/bpf/c/d5288c519bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


