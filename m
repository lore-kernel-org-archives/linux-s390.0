Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349218E025;
	Sun, 27 Sep 2026 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541676; cv=none; b=mXeGiWUXp31Tg7Yp0QYZTFvS0an3PlYtXP64L5HfLOLTfi59iFIsToX8FyVL7enr/kGOzPcM4n1NTC2PxHeCBOqsfLXhnnoVDD8d1uPrtqc001dq/KstVUxjN2s9QJacHdU2gFhnnpIP+vjr+QzbHTIW0p95csoLr/2TvONOckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541676; c=relaxed/simple;
	bh=IZx0c5YL4BHjcA0kGkmqaKl9y+gkwGc5SNdMF/976Po=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NC2wWxcxtL8m8H9vqWQfj6RL714A4Bb9aL5VMrpvwrWp87G/SM9KG5agzdHNBvf2Ufm63MxjLRAreUZksZwt6HeClkuUALkx5uSqTnmnSQCGAaknLtDjXWK/oyhjSEdgkmDxRplK6gtlOxcm3uJ6zxDHjpE7PqrLeBEn90WsSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuTmdGnt reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuTmdGnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C091F000FF;
	Sun, 27 Sep 2026 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541675;
	bh=vLO37l59WyVXOc1GaSGyfri+C0pwbOWgxmIfm+nlpBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TuTmdGnt2aTd7EYBIGzQPK6hgv2mwZj/e+iMLaZQhl+kbqjNk+Gn0JGXGu+zgmfyt
	 x+Jeaumu4xurUfC51qiVkNk0aZqWfE6CifBVSz0/DVzlYQAmvmm3NBDuVE8n/xtFeN
	 /T62KvCuyw7jcMax/bVpfRf7QBJnNqHjfoKjCz1UuB6bWyLjvMjJmDUFCT9aw1ttAd
	 nReKDQGOh6/xSa+g0Xh/CaBwmnUWNv9LiHwGPUx39dhZZG3dK6Yzs4TcoD96N7bqud
	 7Ar3WdLf7zr4A7TmUGMUZPzNmmmQZiAt4yLw5kf/7+H14P9PFbPxJ9MmSslmJB0L8d
	 STXnJylkLfaIQ==
Content-Type: multipart/mixed; boundary="===============7476743973010168723=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9d932a22ca908da9378ea281633ddb749453911ac6ae7a27a09e376f9ad02ff7@mail.kernel.org>
In-Reply-To: <20260926135605.1217928-2-florent.revest@linux.dev>
References: <20260926135605.1217928-2-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v5 1/3] bpf: Wait for an RCU tasks grace period before freeing trampoline progs
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,aou@eecs.berkeley.edu,agordeev@linux.ibm.com,alex@ghiti.fr,bp@alien8.de,catalin.marinas@arm.com,borntraeger@linux.ibm.com,dave.hansen@linux.intel.com,emil@etsalapatis.com,hca@linux.ibm.com,hpa@zytor.com,chenhuacai@kernel.org,ihor.solodrai@linux.dev,mingo@redhat.com,linux-arm-kernel@lists.infradead.org,linux-kselftest@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-riscv@lists.infradead.org,linux-s390@vger.kernel.org,loongarch@lists.linux.dev,maddy@linux.ibm.com,mark.rutland@arm.com,mpe@ellerman.id.au,npiggin@g
 mail.com,palmer@dabbelt.com,paulmck@kernel.org,pjw@kernel.org,ritesh.list@gmail.com,sshegde@linux.ibm.com,shuah@kernel.org,svens@linux.ibm.com,tglx@kernel.org,gor@linux.ibm.com,kernel@xen0n.name,will@kernel.org,x86@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:41:12 +0000 (UTC)

--===============7476743973010168723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Wait for an RCU tasks grace period before freeing trampoline progs
>
> When a prog is detached from a trampoline, it is freed after an RCU
> grace period, or an RCU tasks trace one if it is sleepable. This covers
> the tasks that are running the prog, since the prog's enter helper takes
> the matching read lock before the prog is called. On a preemptible
> kernel, it doesn't cover a task that was preempted in the trampoline
> just before the enter helper. That task holds no lock yet, and it calls
> the prog after it was freed:
>
>   BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3f0
>   Read of size 8 at addr ffffc90000055040 by task candidate/110
>   CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g15071f2a1263-dirty #2 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    __bpf_prog_enter_recur+0x3a5/0x3f0
>    bpf_trampoline_6442509193+0x37/0xf1
>    __x64_sys_futex+0x9/0x410
>    do_syscall_64+0xb0/0x530
>    ...
>
> Wait for an RCU tasks grace period before the existing one when freeing
> a prog that was linked to a trampoline. An RCU tasks grace period only
> ends once the tasks that were preempted have run again, and
> bpf_tramp_image_put() already relies on it to free the image. It doesn't
> wait for tasks that sleep in the trampoline, the next commit takes care
> of those.
>
> Only progs that were linked to a trampoline can be called this way, so
> bpf_trampoline_add_prog() marks them and other progs are still freed as
> before.
>
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

Is this the right Fixes: target?

The race being closed here (a task preempted inside the trampoline image
before __bpf_prog_enter*() takes its RCU read lock, while the prog is freed
after only a regular RCU or RCU tasks trace grace period) appears to predate
e21aa341785c.

In fec56f5890d9 ("bpf: Introduce BPF trampoline") bpf_trampoline_update()
switched images with no tasks RCU wait, and __bpf_prog_put_noref() freed the
prog with a plain call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu).

Just before e21aa341785c, the synchronize_rcu_mult(call_rcu_tasks,
call_rcu_tasks_trace) in bpf_trampoline_update() ran before
arch_prepare_bpf_trampoline() rather than after the new image was installed,
and the total == 0 unregister_fentry() path had no wait at all, so a task
preempted in the old image could already reach a freed prog.

Would Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline") be more
accurate, so that stable trees without e21aa341785c also pick this up? The
follow-up 49ca60187380 in this series uses the same tag.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346518503
--===============7476743973010168723==--
