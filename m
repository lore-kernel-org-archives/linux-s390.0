From: frank.blaschka@de.ibm.com
Subject: [patch 0/9] [resend] s390: network feature patches for net-next
Date: Thu, 12 May 2011 07:43:18 +0200
Message-ID: <20110512054318.241733700@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

I have updated the hw_features patch with feedback from Michal
and respined the patch set.

shortlog:
Frank Blaschka (2)
qeth: convert to hw_features part 2
qeth: add OSA concurrent hardware trap

Sebastian Ott (1)
qeth: add owner to ccw driver

Heiko Carstens (2)
claw: remove unused return code handling
lcs: get rid of compile warning

Ursula Braun (3)
ctcm: get rid of compile warning
iucv: get rid of compile warning
af_iucv: get rid of compile warning

KOSAKI Motohiro (1)
convert old cpumask API into new one

Thanks,
        Frank
