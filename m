Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B3242D97
	for <linux-s390@vger.kernel.org>; Sun,  7 Dec 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765081745; cv=none; b=E7z2vZwotcvxtb0UxlESYzOUzlbstq8ahgyViqTDBTMnG2mxnX5iCVCwAs28Css1kXCLHG49sms8m/73P2DUboAACkn6lqxB8uxDZtcP/Wl8KDtvd/Gfd7IrElsuIMs8m6tix9ou+YUgdc3ex6V/QPz4TttraXHB1Lf/Vgafgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765081745; c=relaxed/simple;
	bh=eFje0BYZc36c7GlxVwvHcOD5WpJMi+Oo3iQMgT02PVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gDCWySc6KTVhF0i5Wm5qk5iSXuWqhHKk+PXHqSGllEfT3LQRdnMyiwEFx3Ol0oXB5k4GnhrGtDtMSc3YauHtCE7f1v0y0bQcuTHcFku05XHAfsqzl5qbRJQMfKkbwZkpZqj2CGlfsIn7dEl+a24TF/QsVL4pXr83Z4dKNwi+HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65742d1c7f9so4831299eaf.3
        for <linux-s390@vger.kernel.org>; Sat, 06 Dec 2025 20:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765081743; x=1765686543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUNWBhctNH94PHBLcTezwPnZsKvlmgikXPpcfVicFU4=;
        b=RhuwVuvTrGbyIDU30rb/UtoYea6og2MLSSAQkXzul5LgrdSWIvooz1EE0duuUrSWiS
         1mBELKnYDdQm6Z51+mH/IvWjTqMol1hXVQ3NRmDsQ/N2LLQdyVMJujIRwkeVgh6qI0TF
         ehQf+C6uAZotux3Bm2U7tDQPXy/JDv2GANsnAJzq32z2rj65M9mTY3BzT+Kk9665+iRo
         v35NuX01BD+TbAbEMBcUU8+Sl8hu0b5QwCwwzyil7zkIx0I8BrYPm+1ToS+mkwfh9UUe
         UFVkRxM2hM4MEyBt5sC2KZBbdBvGgd3DXpXHpCczcEebhqTFaz2uX5TXVhd0hqstbgWj
         7Cgw==
X-Forwarded-Encrypted: i=1; AJvYcCWhHS5Gs1VGfzeQLjq1v5gDFkWhQuDyQHM1OIVGKagbNq7+T+CViWrMh3sOIG5+VU57SpjSX7vFwJX9@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKWEfumljU4ACaqtddVk61ZAo0z+pWIYuLdvl/XZld/meXyL4
	71+FdScmaBYVyMFeSM5Qulprvi2KePBjXQejX81uIkRmZMKXROVXzJLE5Atr7HLuX96pDV2SSWO
	7abrybbP2RPpzqRZjjo/bAZopDaFP+BxUOYrz+fIPY7BoHcoZxroTs3cAz7c=
X-Google-Smtp-Source: AGHT+IHSeHYCjH1WF30LC4vlZ9tiWk2MUfW3UKXh1nskP+uvymmYU7oe3qVXmpZw1STQmVgtt4N2m3Kw9QoZWaaBCcXocytzU+OS
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80b:b0:659:9a49:8f33 with SMTP id
 006d021491bc7-6599a973dc8mr1988629eaf.68.1765081742693; Sat, 06 Dec 2025
 20:29:02 -0800 (PST)
Date: Sat, 06 Dec 2025 20:29:02 -0800
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6935028e.a70a0220.38f243.0041.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	gbayer@linux.ibm.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, julianr@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com, wintera@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d324a2ca3f8efd57f5839aa2690554a5cbb3586f
Author: Alexandra Winter <wintera@linux.ibm.com>
Date:   Thu Sep 18 11:04:50 2025 +0000

    dibs: Register smc as dibs_client

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64eb4580000
start commit:   dbb9a7ef3478 net: fjes: use ethtool string helpers
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f0d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10906b40580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: dibs: Register smc as dibs_client

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
