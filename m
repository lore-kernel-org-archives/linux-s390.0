From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] s390: qeth fixes for 2.6.26
Date: Fri, 06 Jun 2008 12:37:43 +0200
Message-ID: <20080606103743.638691000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Jeff,

I hope these are the final qeth fixes for 2.6.26

shortlog:
Frank Blaschka (3)
qeth: layer 3 Oops in ip event handler
qeth: reduce number of kernel messages
qeth: start dev queue after tx drop error

Cornelia Huck (1)
qeth: Use ccw_device_get_id().

Peter Tiedemann (1)
qeth: Prepare-function to call s390dbf was wrong

Thanks,
        Frank

-- 
