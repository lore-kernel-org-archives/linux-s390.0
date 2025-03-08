Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F811991B8
	for <linux-s390@vger.kernel.org>; Sat,  8 Mar 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472243; cv=none; b=W2DRHfJS2XcdqSljt9cvkzSIjo25tPs1Mouf37/VLLr/50ickf3Jq+rKk1C2HI9U475k4nmnqvfvXZljygPbsNWuP/W87GJCx65xBdbED8NCaO2st0H+vP9wOrjyfA+8OUrWW8YIb7IewoccGHR4zwjngFw7gwNdDABibolN4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472243; c=relaxed/simple;
	bh=VIbf+LpxRASsny0dM7fDcE6Ap5R7QKEGn7yxJ67XwFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JU10zlQnvTgqcPX63bZYJmeEobVYEtUEm4s13s3otUG7OsD8EqlnJNdg1bdDpCwE++mHlYPPoY1uNQdM0E86O6HuSoC6498aLd360mKSowh6uuZpiEDRPyaViYzsQSpxxkN05r3RRVJJ/tYn2jLuV91CekSncurGeVGiNkZyNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so27641325ab.0
        for <linux-s390@vger.kernel.org>; Sat, 08 Mar 2025 14:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472241; x=1742077041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7Zk9cB3ZjVYppJmt/zIVvvTzDcjLPcmPA98lMqVoXY=;
        b=bLfaQ3l6217isyt0/mlRb6bsVTvfvH2iFVS8Nu25wiipZ6Jx4djj7v94dzYLT+QDlu
         7bau3BpFu4hmn3DZxl2RHui/GgOi41YMlwUJQ+B1Fplu+2Q+5OOcTWFblydQB8ywP9zK
         OOQIgAQwM1mJlyg3rD8WEvqAUgrNEqSR+37YNAnvMKSyKeGLX8A/tkHBsIp77m/i06FX
         OPi7AMb9g6PyEBli3pBNjoCw4FR/GMiJztMhSwNqtR4l/0xpshvDUHER5oHZkC2jE0zD
         AcoyXctKKeC3Lxudry1etSnp8guaBdENBnZyT+2ofYcnalt00YgTCfSzulbWNVtp9DRg
         vLMA==
X-Forwarded-Encrypted: i=1; AJvYcCW+a1sNH7QoKa8+2sz16H584nNogmdg6yZHGk2S0/QqJOm2Z9pKhDHRz2SMRaBFfbqEgdQZy6msiTW2@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkkh24NeGnY/vzpKL7cmY1lNNjo9qnQfb7QyaLjkFxXxWJc3p
	X7SjTLkBy+RdwF4hQifNBP7uZC9fXlN9sci49m7fp4FbgLPeAxnmauTT9bwPtSbwdFVzRy8d5g0
	MhfAoccbf7Qzf1UOi2TJ8HqsPr9D/bqufAtRWw1dP9AzfrJYsT93/rAA=
X-Google-Smtp-Source: AGHT+IG4jODR+Cz+704vQP4AW33j/NCHNWn2peiV2QKBCOeMSirU/8gnkop8VMYl7wuNL/D3jnggDiXJ21lIUGyKvzQu0vX0UKmy
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:3d3:fa69:6763 with SMTP id
 e9e14a558f8ab-3d44194730cmr106170415ab.2.1741472240829; Sat, 08 Mar 2025
 14:17:20 -0800 (PST)
Date: Sat, 08 Mar 2025 14:17:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1f0.050a0220.14db68.005a.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Mar 2025)
From: syzbot <syzbot+list5aa65644226f16002659@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 23481   Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2802    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 236     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 66      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<5> 44      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
<6> 12      No    possible deadlock in smc_sendmsg
                  https://syzkaller.appspot.com/bug?extid=6cc62f8d77a830dba3a7
<7> 10      No    possible deadlock in smc_shutdown (2)
                  https://syzkaller.appspot.com/bug?extid=3667d719a932ebc28119
<8> 2       No    KASAN: slab-use-after-free Read in __pnet_find_base_ndev (2)
                  https://syzkaller.appspot.com/bug?extid=9c7519dcc554d2511da3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
