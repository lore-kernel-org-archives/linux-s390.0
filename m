From: Frank Pavlic <fpavlic@de.ibm.com>
Subject: [PATCH 0/4]: s390: network driver fixes and feature
Date: Wed, 2 May 2007 15:13:32 +0200
Message-ID: <20070502131331.GA13217@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, fpavlic@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi ,
this is the second version of patches I have sent already two days ago.
I removed the kthread_run patch (3/5) .

Patches 1-3 contain fixes,patch 4 includes some 
kind of a new feature although it is just an adaption 
to the latest OSA hardware specification
and just prints out human readable text on 
specific error return codes.

Please apply them .

Thank you .

Frank
