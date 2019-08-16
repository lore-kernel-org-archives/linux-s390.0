Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfHPPPO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Aug 2019 11:15:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 0/1] s390dbf logging for vfio-ccw
Date: Fri, 16 Aug 2019 17:15:04 +0200
Message-Id: <20190816151505.9853-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The current discussions around uuids and mdev devices got me thinking,
and I realized that the uuid is an interesting information for
debugging devices.

Currently, vfio-ccw does not really log any debug data (there's just
a lone trace event). The common I/O layer has logged interesting
information into the s390dbf for a long time; this has been very
useful in the past, as the logged information can be accessed in a
crash dump (e.g. by the crash tool). We cannot log directly into
the common I/O layer debug features, though, as vfio-ccw may be a
module.

Another limitation is that for the sprintf-type debug feature, any
string logged via '%s' must outlive the debug feature (as it is not
copied for performance reasons). That means that logging the device
name is right out, as devices may go away (the current common I/O
layer code logs the numerical values of ssid/subchannel number instead);
logging the uuid of an mdev device via %pU just works fine, though.

My patch just logs some basics right now, we can certainly add more
events. We should also think about adding more trace events: they
may serve a similar purpose, especially if we should enhance the vfio
code with trace events in the future (so that we can correlate those
trace events with the vfio-ccw trace events, just as we can correlate
the s390dbf events with the common I/O layer dbf events to get a more
complete picture.)

Cornelia Huck (1):
  vfio-ccw: add some logging

 drivers/s390/cio/vfio_ccw_drv.c     | 50 ++++++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 51 ++++++++++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 10 ++++++
 drivers/s390/cio/vfio_ccw_private.h | 17 ++++++++++
 4 files changed, 124 insertions(+), 4 deletions(-)

-- 
2.20.1
