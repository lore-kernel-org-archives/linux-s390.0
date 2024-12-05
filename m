Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854151DDC3C
	for <linux-s390@vger.kernel.org>; Thu,  5 Dec 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389650; cv=none; b=Pje+cLQDhz6xLysH4FD+b1CsUigUUw/+55TmMX6+HKDMobXsgLeO00ZRxBsyHOWjycEdbTIIWQaWbONJKri8U0kVfOpfDFvqGF6bOWR7cteCVPU6uz5rtmB2gWCNk7FEumEQd405kItSKU3GsS5oUpnAji/dvFMWda3xbulLzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389650; c=relaxed/simple;
	bh=/o7rulEOMmEM63qzozE5OYyLL26cvsEyiLzEXWZ5/Gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O1af5pTy0Obb2gu17csbV4T1/Spa/B8eZ4EuLDoeX9JQI72Md28jT7WMTFtsLgU376In6NGoJlMTd4VMTnEFhSfZqkywaW+Yc4NUC7akKSaMtAM8+4p2QIM3ABEMD79tR+/If+3r523g1ybO9dgglDcZCovvh8lJsEV5NIxOo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841843a9970so56694839f.3
        for <linux-s390@vger.kernel.org>; Thu, 05 Dec 2024 01:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389647; x=1733994447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdfhs6MEPSrhsH7kSPgh77gARjdDh/yQz65BJfBdd6g=;
        b=RJhE7W1qCveJOno3Fbi856flazVYQMnw2P/IulBTawGZkIInuZUPvJWYrJIBK8kzPl
         H2neG4vNNJcU8QF2rBf9YZsMs7lrXIBvZmKJyVcdqEXeoMXoxtZr3LzxZ8v8R4Le5FuF
         ypVSZanKkLZMDwrxeq7wBohZ/AiGw+Ei5ndpfhQ29aBLLt204mUd3BFQCiH/UBY9V4VG
         ZvK/bL8RrYcqxKBvPqVkadj3v2tsr/wFjcSqXndL+AY0QD72dRTkUIrInGpX9WN7AH/3
         N7V6orXcbUke8qAw1RRQwTlQWZkW7YUX/XtM9MJs366yc30FdjqW8O58Gwq7PVebyyTB
         e+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUigxkPXMFcrgjhKwmshnrc/Auwe7oKh2FP1ZS9DVcnhPIGYE9qeEmWR1IaRrcssOmjVblxgLEOSnPH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UZU9casu23ema+RKHqgFKey6wlrwfDqmTQSWFZRiZedXcrlP
	RfO49AtnjTqFCZpZWmxcMpTckpirCvWkq2Wr0oMKdBHymeA0WNugsx4GvqRtS/GlP9+F2kW//ZP
	zWCjb/JwjQYvvuZJ2TSBf7JZOC7Sw7LbIpWQjcpEgahbcMwzj/j8auEo=
X-Google-Smtp-Source: AGHT+IEbVmcaA2agxb79Tmka2U+KOGZdRW6zI5+MW2smkxNHgIizPfWV+o/Id4tUZavjN78CF5tbTpekTpPshAcE3sQXLGUFivmN
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2146:b0:3a7:e528:6edd with SMTP id
 e9e14a558f8ab-3a7f9a55af6mr118113795ab.12.1733389647682; Thu, 05 Dec 2024
 01:07:27 -0800 (PST)
Date: Thu, 05 Dec 2024 01:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516d4f.050a0220.17bd51.0091.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Dec 2024)
From: syzbot <syzbot+list695771e1b19eaf02e5f2@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7345    Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2006    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 105     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 34      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
<5> 34      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<6> 8       Yes   Unable to handle kernel execute from non-executable memory at virtual address ADDR
                  https://syzkaller.appspot.com/bug?extid=8798e95c2e5511646dac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
