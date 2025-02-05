Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107722CBF0
	for <linux-s390@vger.kernel.org>; Wed,  5 Feb 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759407; cv=none; b=icpWPO0srBaIxIm7QZ8e+aE/NZvjdeUCXu/wnaQDzsctcw/qHKsR6racoZBW1cFqu4d62DCVq11auc3hynY5Z/nbEVofXtc9VI+S9Hr+Ve33pz21+Cg3yKl9JSU81sd1GGirWqhGSd/5G3CKyeB/SNA/usyIVEu5cqfF0y0KGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759407; c=relaxed/simple;
	bh=MFwWo9skWE6TgrrIuG9Dg1rbyddXG8DLp+DwyUcHO/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tnvbtS6J+jemJMUuiUufylKA497e+HiVCQfpJcZkSEnl6P+nlcmqTah/8amzuxLBe933zBM/ShLoUjrMsBsUgIq6lXKo0tDkHPtbl5udDzxj68LceyEX5N1irTSs9e+OiS4pz8B9ZB/bAvzkofcWQDjX2/Zq5agECK/O+FA2g5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d0508b8008so4422805ab.0
        for <linux-s390@vger.kernel.org>; Wed, 05 Feb 2025 04:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759404; x=1739364204;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qE+fXc1pHOhxeyOdSmAnMaDoJYrhg+xmOJDX5G4+jRw=;
        b=HJe17i3mMSAyNQWG68fwHTc7iPWZ0xnY2blPBo0YCNV2H7Vd6/6CkEjDYs1Nse9Kdb
         WCaN6x0ibEVcX3gnyax/kJn6kqMe0jkcyzJ2+pXPTOSfJfS+Tzk2nUlKGO/m4FSb2fTW
         iYnGwU56RrsRSZp+3u4L9/h0g5BseDkVaBrOepzKLB8SQSp+oCMG76uV6zWl7fLXEXdQ
         F8UY3HwwqU4bgheo3MYOH7WznHWd+8nFD63hyULgJAvGz7aYAeGyrJJxopmT/9AZKQZl
         xJVGIK6ZdiIw7fdYa5UeQFjrcwf8nGTbeU9Urv573MkNvvzUlELHkDuVNf4+p05xTojR
         lHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb4n0IQHzoSdg7hvupR4Gfq3Kg56PZms47v45DKK6ctxONj0JDuuSPOk3mCbQ+p83TkmDGFRbid7mT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4btWKNXi1kzpj57xk4FX2tqYrDHQ8x1M1OFg04Guam1I4gLzl
	WPX4mzm/bqFooxQN0Cl+dOdy/hQpU8i+3urXjq2TJkALEYigntpHbE0LvsJSkfDckSQOXI3C8Qe
	fv8yawPKREwF3s34h2izTp58OMLzGJw7R55fpbASUllW0eFy2jS9V/oQ=
X-Google-Smtp-Source: AGHT+IHXWRgilzd3XNVpmJ5vIWEJ3GQ8019fDmXhYFTPWkCFU4PsLj9OkZ3YQ86PBm04LC/9AK62WTRpSIP3t6lhhRuG/88ASsAD
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:3cf:c8ec:d375 with SMTP id
 e9e14a558f8ab-3d04f2c7559mr25490575ab.0.1738759404554; Wed, 05 Feb 2025
 04:43:24 -0800 (PST)
Date: Wed, 05 Feb 2025 04:43:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a35cec.050a0220.50516.0052.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Feb 2025)
From: syzbot <syzbot+listc2bca56bae687bb9de83@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 4 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 20019   Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2669    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 204     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 51      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<5> 41      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
<6> 8       Yes   Unable to handle kernel execute from non-executable memory at virtual address ADDR
                  https://syzkaller.appspot.com/bug?extid=8798e95c2e5511646dac
<7> 8       No    possible deadlock in smc_shutdown (2)
                  https://syzkaller.appspot.com/bug?extid=3667d719a932ebc28119
<8> 5       Yes   possible deadlock in smc_pnet_find_ism_resource
                  https://syzkaller.appspot.com/bug?extid=f160105b2817964a0886

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
