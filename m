Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460725B08E
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633316; cv=pass; b=NFo9VAMEEf75V9NRXQuvLp1k77NPkLMlPkZb5LEYXkxZiAem6JtJhApB8uOjZi3O9KNQo4At6lCaic+PUxhn+4f3UB+L1byp5LtDgBdpo56N2ooLGiBQJwTV1YIEQDH8s4UtLOJLMHiK3+0GE54uU6a7Tx1qQ19Wpr0eMVqRngM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633316; c=relaxed/simple;
	bh=TsiJ/Phl1DHyVrc/OMR6Qq9BtAPEyE8Kj2F+jc+zsAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SADQB0f3l28h9ExbSUdj0L5hQ7St/F6J7xOk7GByOtv4drTKWBlZ7iLY2i5hwtwRq1+0rQUr6i3hMXEj/0EriwEhmePdA/SDug8npv6KM75S26RD5L0D0qbZC4aH5O40Zj2lE26SWmiiS6RMUwGj7x1L9i4HeJVjZxWq58hYsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSJtSssO; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSJtSssO"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1334825de43so1553952c88.0
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 17:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778633313; cv=none;
        d=google.com; s=arc-20240605;
        b=Al2wyuLkMhXPq52i167GfmAvhMIsTopYdZmECLHSj4J3lTy5KLuLlB5qywAo4MWByg
         P89Lqcho1mxm1C/kp5ObBY3HAK/rMXRxppr2SgFLYARW2pr5ueSDlyBsuj838IVeWfId
         1snmUcTpH5sH5A4IK7j2xHwyLrg947wy6/FN8gYYE4DUcl2Ku/rzZ1Pq5+SIRKnlp2uh
         inOHXmQDOGAQHpPErQaS+Fh0Pq4frjHqaodyL7DdwBLEI5zq3JcoW3oeC/qPktMCfg68
         usZ7WJn7tZGlM9IcPx1cFIuEo4QA5DHNgaPHCrPBMm4q7UOKIZlSXjaErz7etWaLvjvJ
         Y5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GsTJPPxGxOiLB5hKatEbvArA7sIDX/ZxB63WC4Bycpk=;
        fh=TbANPyiDct8cSh9ewa11BGbKfSXwLDRDfK+nfLUDXk4=;
        b=Be7fhQurAhp963KYPvMXLvpJRw/lYiyR7CBcS6Ntiu+ef1S2RvnsgBGBZZTV1kchJg
         ua3sKk3VPSKdp9HbLKPtaeQJf6PfnOuBYzVQG3+52XPx548qXHmK7vlL4PHc+dDuG1dr
         Wfy40buaMutJty/dOJ1F3UknPo5zFZtUmyNkRnKZGRf6TboYbESJEksOu5ZnHG+kxNmV
         JB5GS9h4ga+ZI0tzgjNCj8Zg9S6UHr4thuztCROerFuz2SEVBy5q4ZuQIqAKRvFLGaN/
         CSqq6zsPQM3ibm3dfTU5Bzz6AphUyFWCh6VSgrwjvGta0zM7ZrWuWQDK9nJOeZQxIGm8
         iNmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778633313; x=1779238113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsTJPPxGxOiLB5hKatEbvArA7sIDX/ZxB63WC4Bycpk=;
        b=CSJtSssO0txZZDk3LfKp3VdNeORkXqlEnvx/pQTxQ3ghHbGCkcCB1HsyJ5cjEQXrJJ
         YVWy0D9DKlQHamHG77pFYRdS6lc8wRLj+ypppaCobn5F+PDuqO5v/OWgjLEQeWauKCci
         rG4cAy7BTqCQgyCrwOlHGwESwwKPjMGlenBvvOMOG4NCoRRJzZHPkIGMrZ85h89h8KKW
         UzKLSYifBE3lZnShiBIDL+rbx3PKUBKK3B0hX0xBgcc+FkxSNVSrkETmghXr7SLq6Rg9
         rbBkdexPkTKjs5ZZVh1TMRkNdPzvmiPclWkmOwmzAFVeD2y1ZbaNJ07S8ktxOKCJ/0Ch
         3pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778633313; x=1779238113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GsTJPPxGxOiLB5hKatEbvArA7sIDX/ZxB63WC4Bycpk=;
        b=dkvAGZXPAPUCD5Mk9SIpmoKzKpoQ4YEAq/wP8Fv40Kq2IBmg6OeQVm5gWWfrHD9gVj
         ClPDb+I/a0Mfg4tFVolTO3cZqhBRKLIl6NSQPoEEHXN+p0LxLfLaTDfg1JMd3XTckBba
         7VSperHVhgfQzekH1AVfsxOX+4MMKG/6GeEajgyOkkaS5BzF3iiEnYt03XVrISsJhE32
         c3yPMJt7uvUkpyds1K/NxxWS2v7gUmE1W4SWDydlEYajuxFpJosX5eZoDCLw5iA0LJdr
         qDAr3CbxRhqVrV9icQ626k4LVfBrBpw7WUOnY16UhHoygSrJAgl0SZ3EAPAvcsb6r7vo
         EWLw==
X-Forwarded-Encrypted: i=1; AFNElJ/K+kim9pPiblxkGO21UampvKIgjccZpooU2XC52NjF8H3p3VpI3FER/i70I2nJa9mTGhNfQWqhtfLd@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+Gc94T6ImTxBXSkfmugn+ALxI50h5Y2H916ek4N+GDqgOy3j
	wVlnWOlmeJT3pGHfMfQFNsY5Oj9xwtxVUUzquPLi70bsztTNsqSvSB3J1BuOHDk0HGeb4N0/m07
	b5HegXwiwcv5QzpZdaTuRQOy/VRQWzXhA1NST9+Y=
X-Gm-Gg: Acq92OG7WqzCsIDVRfrxjalRfETaiuTuD1Kzy7KqIr6LN31KgXpZQrIIuPPnkPE3D03
	J9CkQRdZzff4xBeVRZ1VEw33EbWzT6T098shG6aM3U6DYpfne+9aM6QoxJef/uF+xoud26NCskq
	XXhI+8Il1HvOP5Wu5i1BQlWyICZ2mmWIMmzACu8PcvcW8DDOnSvrr7kLLtkKBWi2wzTgX+ReDwk
	5PdrBjsT5xbe987ic6aGX8syJFEy/6RPjFfXMGrP+dM2rHqd7VFtDHhrLwDRbYP0ALCX8Tu+3IF
	56jnQ22jfffsaZvgVgnWw9QNmaUG28ppWYvdh5c42fISxJ3u8S292QZ7XOe2Qp515O1VuXiM72Z
	K1hATqXGUjv99fNryvbZJZUUVuV5aMEv4fiMQtn0w3BudBsVhZ7rfpeEQ
X-Received: by 2002:a05:7022:527:b0:12d:de3e:86b6 with SMTP id
 a92af1059eb24-13436bb07b7mr654018c88.38.1778633312692; Tue, 12 May 2026
 17:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c00-02.v2.ttenwd4@ub.hpns> <CANDhNCoJHSaiZiD7xgqd-L9LXq2-iGU-4FtjVGy0PP2uRpnxEw@mail.gmail.com>
In-Reply-To: <CANDhNCoJHSaiZiD7xgqd-L9LXq2-iGU-4FtjVGy0PP2uRpnxEw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 17:48:19 -0700
X-Gm-Features: AVHnY4L0Lqi8ncDwnVJlo4PO_EyIeVGyug3Dg0oVztR-GyoN8xhpGY25Znq2QbU
Message-ID: <CANDhNCrw9mNzj4adr8e-X-hA-PceTmDxNS6hvgSw+z0Xt9sKxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sched/core: Fix proxy-exec/core-sched interactions
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vineeth Pillai <vineethrp@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:17=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> On Thu, May 7, 2026 at 3:42=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.com> =
wrote:
> >
> > v1 [1] consisted of a fix for a scheduler corruption where
> > try_steal_cookie() could migrate a proxy-exec donor away from the sourc=
e
> > rq while that rq still used it as the active scheduling context.
> >
> > Prateek pointed out [2] a separate proxy-exec/core-sched issue: after
> > pick_next_task() selects a core cookie compatible donor, find_proxy_tas=
k()
> > can replace the execution context with a mutex owner with a different
> > cookie.
> >
> > This v2 keeps the donor steal fix as patch 1 and adds patch 2 to reject
> > mismatched final proxy owners.
> >
> > The v1 reported the issue reproduced on s390 LPAR, but it seems to be
> > easily reproducible with strace test suite "make -j$(nproc) check" on
> > any system with SMT, CONFIG_SCHED_CORE=3Dy and CONFIG_SCHED_PROXY_EXEC=
=3Dy
> > enabled, e.g. on x86 KVM with -smp cpus=3D16,sockets=3D1,cores=3D8,thre=
ads=3D2:
> >
>
> Vasily! Thank you so much for reporting this and working out fixes
> (along with K Prateek!)
>
> Apologies for being slow to reply, I've been under the weather.
>
> I really appreciate this reproducer detail, but I've so far not been
> able to trip this issue up (SCHED_CORE=3Dy, SCHED_PROXY_EXEC=3Dy and usin=
g
> the qemu arguments you included above). Could you mail me your .config
> in case something else is needed?

Ok, I think I was able to force it using my priority-inversion-demo by
taking the spots in the run.sh script where we kick off the
rename-test and prefixing it with `coresched new -t pid --`
  https://github.com/johnstultz-work/priority-inversion-demo/blob/main/run.=
sh#L89

That way the foreground/background tasks run with separate cookies and
that forces proxying across cookies, and with that I've tripped over
the issues you highlight.

That said, I'm still curious to learn more about your x86 environment
and why it tripped so much more easily there, so let me know.

With your patches it does seem to resolve things, but I'm also hoping
to find some better ways to more thoroughly stress the
proxy+core-sched logic.

thanks again!
-john
