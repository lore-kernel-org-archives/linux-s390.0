Return-Path: <linux-kernel-owner+w=401wt.eu-S1756491AbYJORtv@vger.kernel.org>
Message-Id: <20081015174215.337001494@de.ibm.com>
Date: Wed, 15 Oct 2008 19:42:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/5] latest fixes for s390.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Five new bug fixes for s390:

Christian Borntraeger (2):
      [S390] vmcp: remove BKL
      [S390] pgtables: Fix race in enable_sie vs. page table ops

Heiko Carstens (1):
      [S390] Fix sysdev class file creation.

Jan Glauber (2):
      [S390] qdio: prevent double qdio shutdown in case of I/O errors
      [S390] qdio: remove incorrect memset

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
