Return-Path: <linux-kernel-owner+w=401wt.eu-S1767583AbXECR4Q@vger.kernel.org>
Subject: [RFC] [Patch 0/3] readahead statistics slimmed down
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 19:56:11 +0200
Message-Id: <1178214971.5639.76.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@gmail.com>, Fengguang Wu <wfg@mail.ustc.edu.cn>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch set simplifies the statistics code of the adaptive readahead
feature by using the proposed statistic infrastructure.

Patches are against 2.6.21-rc7-mm2.

[RFC] [Patch 1/3] readahead statistics slimmed down, statistics prereq
[RFC] [Patch 2/3] readahead statistics slimmed down, adapt zfcp
[RFC] [Patch 3/3] readahead statistics slimmed down

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
